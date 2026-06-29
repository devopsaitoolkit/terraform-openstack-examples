# Architecture & Workflow Diagrams

This document collects GitHub-renderable [Mermaid](https://mermaid.js.org/)
diagrams that explain how the Terraform examples and modules in this repository
map onto OpenStack. They cover the Terraform lifecycle, the OpenStack services
Terraform drives through Keystone, the networking model, storage and boot flows,
identity layout, how the reusable modules wire together, and how teams share
remote state. Each diagram is paired with a short explanation so you can use the
section as a learning reference or as onboarding material for a private cloud
platform team.

All labels avoid unescaped parentheses and pipe characters so the blocks render
correctly on GitHub.

## 1. Terraform workflow

The core loop for any example in this repo: you author HCL, initialize the
working directory to download the OpenStack provider and configure the backend,
validate syntax, generate a plan, then apply it to converge real OpenStack
resources. Terraform records what it created in state, and `terraform destroy`
tears everything back down using that state. The helper scripts under
`scripts/` wrap each step with safety checks.

```mermaid
flowchart LR
  W[Write HCL config] --> I[terraform init]
  I --> V[terraform validate]
  V --> P[terraform plan]
  P -->|review diff| A[terraform apply]
  A --> R[Real OpenStack resources]
  A --> S[(Terraform state)]
  S -.tracks.-> R
  P -.refresh.-> S
  R --> D[terraform destroy]
  D --> S
  D --> X[Resources removed]

  classDef cmd fill:#7B42BC,color:#fff,stroke:#4b2a73;
  classDef store fill:#2d6cdf,color:#fff,stroke:#1b3f85;
  class W,I,V,P,A,D cmd;
  class S store;
```

## 2. OpenStack core services architecture

Terraform never talks to a service directly without first authenticating to
Keystone, the identity service. Keystone issues a scoped token and a service
catalog; Terraform then uses that token to call each service endpoint. The
`openstack` provider maps onto these services, which is why one set of
credentials drives compute, networking, storage, images, load balancing, DNS,
and object storage.

```mermaid
flowchart TD
  TF[Terraform openstack provider]
  K[Keystone - Identity and token issuer]
  TF -->|authenticate, get scoped token| K
  K -->|token + service catalog| TF

  TF -->|token| NOVA[Nova - Compute]
  TF -->|token| NEU[Neutron - Networking]
  TF -->|token| CIN[Cinder - Block storage]
  TF -->|token| GLA[Glance - Images]
  TF -->|token| OCT[Octavia - Load balancing]
  TF -->|token| DES[Designate - DNS]
  TF -->|token| SWI[Swift - Object storage]

  K -.validates token for.-> NOVA
  K -.validates token for.-> NEU
  K -.validates token for.-> CIN
  K -.validates token for.-> GLA
  K -.validates token for.-> OCT
  K -.validates token for.-> DES
  K -.validates token for.-> SWI

  classDef id fill:#da1a32,color:#fff,stroke:#7a0f1c;
  classDef svc fill:#0b7285,color:#fff,stroke:#063b45;
  classDef tf fill:#7B42BC,color:#fff,stroke:#4b2a73;
  class K id;
  class NOVA,NEU,CIN,GLA,OCT,DES,SWI svc;
  class TF tf;
```

## 3. Networking topology

A typical tenant deployment connects to the outside world through a provider or
external network. A Neutron router attaches to that external network for SNAT
and floating IP allocation, and connects internally to one or more tenant
networks. Each tenant network carries a subnet, instances attach via ports, and
security groups filter traffic on those ports. Floating IPs are bound to ports
to expose selected instances publicly.

```mermaid
flowchart TD
  EXT[External / provider network]
  R[Neutron router - SNAT and floating IPs]
  FIP[Floating IP]
  TN[Tenant network]
  SUB[Subnet - CIDR and DHCP]
  P1[Port - instance 1]
  P2[Port - instance 2]
  SG[Security group rules]
  I1[Instance 1]
  I2[Instance 2]

  EXT --> R
  R --> TN
  TN --> SUB
  SUB --> P1
  SUB --> P2
  P1 --> I1
  P2 --> I2
  SG -.applied to.-> P1
  SG -.applied to.-> P2
  FIP -.maps external to.-> P1
  EXT -.allocates.-> FIP

  classDef ext fill:#b5651d,color:#fff,stroke:#6e3d11;
  classDef net fill:#0b7285,color:#fff,stroke:#063b45;
  classDef inst fill:#2d6cdf,color:#fff,stroke:#1b3f85;
  classDef sec fill:#da1a32,color:#fff,stroke:#7a0f1c;
  class EXT ext;
  class R,TN,SUB,P1,P2,FIP net;
  class I1,I2 inst;
  class SG sec;
```

## 4. Volume attachment

Attaching a Cinder volume to a running instance is a two-service operation.
Terraform asks Cinder to create the volume, then issues an attach which Nova
coordinates with Cinder. Nova exposes the block device to the hypervisor and the
guest, while Cinder flips the volume to the `in-use` state. The reverse order
applies on destroy.

```mermaid
sequenceDiagram
  participant TF as Terraform
  participant N as Nova - Compute
  participant C as Cinder - Block storage
  TF->>C: Create volume
  C-->>TF: Volume id, status available
  TF->>N: Attach volume to instance
  N->>C: Reserve and initialize connection
  C-->>N: Connection info
  N->>N: Expose block device to guest
  N-->>TF: Attachment created
  Note over C: Volume status becomes in-use
  TF->>N: Detach on update or destroy
  N->>C: Terminate connection and free volume
  C-->>N: Volume status available
```

## 5. Boot-from-volume

Boot-from-volume decouples the instance root disk from the ephemeral hypervisor
disk. A Glance image is used as the source for a new bootable Cinder volume, and
the instance boots from that persistent volume instead of local storage. This
lets the root disk survive instance deletion and supports larger or replaceable
root disks.

```mermaid
flowchart LR
  IMG[Glance image]
  VOL[Bootable Cinder volume]
  INST[Instance boots from volume]
  PERSIST[(Persistent root disk)]

  IMG -->|source for| VOL
  VOL -->|root device| INST
  VOL --> PERSIST
  INST -.delete does not remove.-> PERSIST

  classDef img fill:#0b7285,color:#fff,stroke:#063b45;
  classDef vol fill:#2d6cdf,color:#fff,stroke:#1b3f85;
  classDef inst fill:#7B42BC,color:#fff,stroke:#4b2a73;
  class IMG img;
  class VOL,PERSIST vol;
  class INST inst;
```

## 6. Project and identity layout

OpenStack identity is hierarchical. A domain contains projects and the users and
groups that act within them. Roles are granted through role assignments that bind
a user or a group to a project, which is what gives Terraform permission to act.
For automation, application credentials derived from a user provide scoped,
revocable secrets that avoid embedding a password in `clouds.yaml`.

```mermaid
flowchart TD
  DOM[Domain]
  PRJ1[Project app-prod]
  PRJ2[Project app-staging]
  USR[User]
  GRP[Group]
  RA[Role assignment - member or admin]
  APPC[Application credential - scoped and revocable]

  DOM --> PRJ1
  DOM --> PRJ2
  DOM --> USR
  DOM --> GRP
  USR --> GRP
  USR --> RA
  GRP --> RA
  RA -->|grants access to| PRJ1
  RA -->|grants access to| PRJ2
  USR --> APPC
  APPC -.used by Terraform.-> PRJ1

  classDef dom fill:#da1a32,color:#fff,stroke:#7a0f1c;
  classDef prj fill:#0b7285,color:#fff,stroke:#063b45;
  classDef idn fill:#2d6cdf,color:#fff,stroke:#1b3f85;
  class DOM dom;
  class PRJ1,PRJ2 prj;
  class USR,GRP,RA,APPC idn;
```

## 7. Module relationships

The reusable modules under `modules/` are designed to compose. A root example
creates a network with the networking module, defines a security group, launches
instances with the compute module while passing in the network and security
group, allocates and associates a floating IP, and fronts the instances with an
Octavia load balancer. The arrows show how each module consumes another module's
outputs.

```mermaid
flowchart TD
  ROOT[Root example - main.tf]
  NET[module networking]
  SG[module security-group]
  CMP[module compute]
  FIP[module floating-ip]
  LB[module loadbalancer]

  ROOT --> NET
  ROOT --> SG
  ROOT --> CMP
  ROOT --> FIP
  ROOT --> LB

  NET -->|network_id and subnet_id| CMP
  SG -->|security_group_id| CMP
  NET -->|subnet_id| LB
  CMP -->|instance ports| LB
  CMP -->|port id| FIP
  NET -->|external network| FIP

  classDef root fill:#7B42BC,color:#fff,stroke:#4b2a73;
  classDef mod fill:#0b7285,color:#fff,stroke:#063b45;
  class ROOT root;
  class NET,SG,CMP,FIP,LB mod;
```

## 8. Remote state

By default Terraform stores state on local disk, which does not work for teams.
This repo documents an OpenStack-native backend that keeps state as an object in
a Swift container. Each team member configures the same backend, so Terraform
reads and writes one shared state object and uses state locking to prevent
concurrent conflicting applies.

```mermaid
flowchart LR
  LC[Local backend config]
  BK[Swift backend]
  OBJ[(State object in Swift container)]
  M1[Engineer 1]
  M2[Engineer 2]
  CI[CI pipeline]

  LC --> BK
  BK --> OBJ
  M1 -->|init with same backend| BK
  M2 -->|init with same backend| BK
  CI -->|init with same backend| BK
  OBJ -.shared and locked.-> M1
  OBJ -.shared and locked.-> M2
  OBJ -.shared and locked.-> CI

  classDef cfg fill:#7B42BC,color:#fff,stroke:#4b2a73;
  classDef store fill:#2d6cdf,color:#fff,stroke:#1b3f85;
  classDef people fill:#0b7285,color:#fff,stroke:#063b45;
  class LC cfg;
  class BK,OBJ store;
  class M1,M2,CI people;
```

## 9. Provider authentication

Authentication starts from a named cloud in `clouds.yaml` selected by the
`OS_CLOUD` environment variable. The provider sends those credentials to
Keystone, which returns a scoped token and a service catalog listing endpoints.
Terraform then makes API calls to each service endpoint carrying that token,
refreshing it as needed for the duration of the run.

```mermaid
sequenceDiagram
  participant U as Operator shell
  participant TF as Terraform provider
  participant K as Keystone
  participant SVC as OpenStack service endpoint
  U->>TF: Set OS_CLOUD and run terraform
  TF->>TF: Read named cloud from clouds.yaml
  TF->>K: Authenticate with credentials and project scope
  K-->>TF: Scoped token and service catalog
  TF->>SVC: API call with token, for example create network
  SVC-->>TF: Resource created
  Note over TF,K: Token is reused and refreshed during the run
```

## Further reading

- [Advanced OpenStack and Terraform guides](https://devopsaitoolkit.com/blog/)
