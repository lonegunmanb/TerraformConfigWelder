variable "kubernetes_cluster_default_node_pool" {
  type = object({
    capacity_reservation_group_id = optional(string)
    custom_ca_trust_enabled       = optional(bool)
    enable_auto_scaling           = optional(bool)
    enable_host_encryption        = optional(bool)
    enable_node_public_ip         = optional(bool)
    fips_enabled                  = optional(bool)
    gpu_instance                  = optional(string)
    host_group_id                 = optional(string)
    kubelet_disk_type             = optional(string)
    max_count                     = optional(number)
    max_pods                      = optional(number)
    message_of_the_day            = optional(string)
    min_count                     = optional(number)
    name                          = string
    node_count                    = optional(number)
    node_labels                   = optional(map(string))
    node_public_ip_prefix_id      = optional(string)
    node_taints                   = optional(list(string))
    only_critical_addons_enabled  = optional(bool)
    orchestrator_version          = optional(string)
    os_disk_size_gb               = optional(number)
    os_disk_type                  = optional(string)
    os_sku                        = optional(string)
    pod_subnet_id                 = optional(string)
    proximity_placement_group_id  = optional(string)
    scale_down_mode               = optional(string)
    snapshot_id                   = optional(string)
    tags                          = optional(map(string))
    temporary_name_for_rotation   = optional(string)
    type                          = optional(string)
    ultra_ssd_enabled             = optional(bool)
    vm_size                       = string
    vnet_subnet_id                = optional(string)
    workload_runtime              = optional(string)
    zones                         = optional(set(string))
    kubelet_config = optional(object({
      allowed_unsafe_sysctls    = optional(set(string))
      container_log_max_line    = optional(number)
      container_log_max_size_mb = optional(number)
      cpu_cfs_quota_enabled     = optional(bool)
      cpu_cfs_quota_period      = optional(string)
      cpu_manager_policy        = optional(string)
      image_gc_high_threshold   = optional(number)
      image_gc_low_threshold    = optional(number)
      pod_max_pid               = optional(number)
      topology_manager_policy   = optional(string)
    }))
    linux_os_config = optional(object({
      swap_file_size_mb             = optional(number)
      transparent_huge_page_defrag  = optional(string)
      transparent_huge_page_enabled = optional(string)
      sysctl_config = optional(object({
        fs_aio_max_nr                      = optional(number)
        fs_file_max                        = optional(number)
        fs_inotify_max_user_watches        = optional(number)
        fs_nr_open                         = optional(number)
        kernel_threads_max                 = optional(number)
        net_core_netdev_max_backlog        = optional(number)
        net_core_optmem_max                = optional(number)
        net_core_rmem_default              = optional(number)
        net_core_rmem_max                  = optional(number)
        net_core_somaxconn                 = optional(number)
        net_core_wmem_default              = optional(number)
        net_core_wmem_max                  = optional(number)
        net_ipv4_ip_local_port_range_max   = optional(number)
        net_ipv4_ip_local_port_range_min   = optional(number)
        net_ipv4_neigh_default_gc_thresh1  = optional(number)
        net_ipv4_neigh_default_gc_thresh2  = optional(number)
        net_ipv4_neigh_default_gc_thresh3  = optional(number)
        net_ipv4_tcp_fin_timeout           = optional(number)
        net_ipv4_tcp_keepalive_intvl       = optional(number)
        net_ipv4_tcp_keepalive_probes      = optional(number)
        net_ipv4_tcp_keepalive_time        = optional(number)
        net_ipv4_tcp_max_syn_backlog       = optional(number)
        net_ipv4_tcp_max_tw_buckets        = optional(number)
        net_ipv4_tcp_tw_reuse              = optional(bool)
        net_netfilter_nf_conntrack_buckets = optional(number)
        net_netfilter_nf_conntrack_max     = optional(number)
        vm_max_map_count                   = optional(number)
        vm_swappiness                      = optional(number)
        vm_vfs_cache_pressure              = optional(number)
      }))
    }))
    node_network_profile = optional(object({
      application_security_group_ids = optional(list(string))
      node_public_ip_tags            = optional(map(string))
      allowed_host_ports = optional(list(object({
        port_end   = optional(number)
        port_start = optional(number)
        protocol   = optional(string)
      })))
    }))
    upgrade_settings = optional(object({
      drain_timeout_in_minutes      = optional(number)
      max_surge                     = string
      node_soak_duration_in_minutes = optional(number)
    }))
  })
  description = <<-EOT
 - `capacity_reservation_group_id` - (Optional) Specifies the ID of the Capacity Reservation Group within which this AKS Cluster should be created. Changing this forces a new resource to be created.
 - `custom_ca_trust_enabled` - (Optional) Specifies whether to trust a Custom CA.
 - `enable_auto_scaling` - (Optional) Should [the Kubernetes Auto Scaler](https://docs.microsoft.com/azure/aks/cluster-autoscaler) be enabled for this Node Pool?
 - `enable_host_encryption` - (Optional) Should the nodes in the Default Node Pool have host encryption enabled? `temporary_name_for_rotation` must be specified when changing this property.
 - `enable_node_public_ip` - (Optional) Should nodes in this Node Pool have a Public IP Address? `temporary_name_for_rotation` must be specified when changing this property.
 - `fips_enabled` - (Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? `temporary_name_for_rotation` must be specified when changing this block. Changing this forces a new resource to be created.
 - `gpu_instance` - (Optional) Specifies the GPU MIG instance profile for supported GPU VM SKU. The allowed values are `MIG1g`, `MIG2g`, `MIG3g`, `MIG4g` and `MIG7g`. Changing this forces a new resource to be created.
 - `host_group_id` - (Optional) Specifies the ID of the Host Group within which this AKS Cluster should be created. Changing this forces a new resource to be created.
 - `kubelet_disk_type` - (Optional) The type of disk used by kubelet. Possible values are `OS` and `Temporary`.
 - `max_count` - (Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000`.
 - `max_pods` - (Optional) The maximum number of pods that can run on each agent. `temporary_name_for_rotation` must be specified when changing this property.
 - `message_of_the_day` - (Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
 - `min_count` - (Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000`.
 - `name` - (Required) The name which should be used for the default Kubernetes Node Pool.
 - `node_count` - (Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000` and between `min_count` and `max_count`.
 - `node_labels` - (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
 - `node_public_ip_prefix_id` - (Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. `enable_node_public_ip` should be `true`. Changing this forces a new resource to be created.
 - `node_taints` - 
 - `only_critical_addons_enabled` - (Optional) Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. `temporary_name_for_rotation` must be specified when changing this property.
 - `orchestrator_version` - (Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by `kubernetes_version`. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as `1.22` are also supported.
 - `os_disk_size_gb` - (Optional) The size of the OS Disk which should be used for each agent in the Node Pool. `temporary_name_for_rotation` must be specified when attempting a change.
 - `os_disk_type` - (Optional) The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Defaults to `Managed`. `temporary_name_for_rotation` must be specified when attempting a change.
 - `os_sku` - (Optional) Specifies the OS SKU used by the agent pool. Possible values are `AzureLinux`, `Ubuntu`, `Windows2019` and `Windows2022`. If not specified, the default is `Ubuntu` if OSType=Linux or `Windows2019` if OSType=Windows. And the default Windows OSSKU will be changed to `Windows2022` after Windows2019 is deprecated. Changing this from `AzureLinux` or `Ubuntu` to `AzureLinux` or `Ubuntu` will not replace the resource, otherwise `temporary_name_for_rotation` must be specified when attempting a change.
 - `pod_subnet_id` - (Optional) The ID of the Subnet where the pods in the default Node Pool should exist.
 - `proximity_placement_group_id` - (Optional) The ID of the Proximity Placement Group. Changing this forces a new resource to be created.
 - `scale_down_mode` - (Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are `Delete` and `Deallocate`. Defaults to `Delete`.
 - `snapshot_id` - (Optional) The ID of the Snapshot which should be used to create this default Node Pool. `temporary_name_for_rotation` must be specified when changing this property.
 - `tags` - (Optional) A mapping of tags to assign to the Node Pool.
 - `temporary_name_for_rotation` - (Optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing.
 - `type` - (Optional) The type of Node Pool which should be created. Possible values are `AvailabilitySet` and `VirtualMachineScaleSets`. Defaults to `VirtualMachineScaleSets`. Changing this forces a new resource to be created.
 - `ultra_ssd_enabled` - (Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to `false`. See [the documentation](https://docs.microsoft.com/azure/aks/use-ultra-disks) for more information. `temporary_name_for_rotation` must be specified when attempting a change.
 - `vm_size` - (Required) The size of the Virtual Machine, such as `Standard_DS2_v2`. `temporary_name_for_rotation` must be specified when attempting a resize.
 - `vnet_subnet_id` - (Optional) The ID of a Subnet where the Kubernetes Node Pool should exist.
 - `workload_runtime` - (Optional) Specifies the workload runtime used by the node pool. Possible values are `OCIContainer` and `KataMshvVmIsolation`.
 - `zones` - (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. `temporary_name_for_rotation` must be specified when changing this property.

 ---
 `kubelet_config` block supports the following:
 - `allowed_unsafe_sysctls` - (Optional) Specifies the allow list of unsafe sysctls command or patterns (ending in `*`).
 - `container_log_max_line` - (Optional) Specifies the maximum number of container log files that can be present for a container. must be at least 2.
 - `container_log_max_size_mb` - (Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated.
 - `cpu_cfs_quota_enabled` - (Optional) Is CPU CFS quota enforcement for containers enabled?
 - `cpu_cfs_quota_period` - (Optional) Specifies the CPU CFS quota period value.
 - `cpu_manager_policy` - (Optional) Specifies the CPU Manager policy to use. Possible values are `none` and `static`,.
 - `image_gc_high_threshold` - (Optional) Specifies the percent of disk usage above which image garbage collection is always run. Must be between `0` and `100`.
 - `image_gc_low_threshold` - (Optional) Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between `0` and `100`.
 - `pod_max_pid` - (Optional) Specifies the maximum number of processes per pod.
 - `topology_manager_policy` - (Optional) Specifies the Topology Manager policy to use. Possible values are `none`, `best-effort`, `restricted` or `single-numa-node`.

 ---
 `linux_os_config` block supports the following:
 - `swap_file_size_mb` - (Optional) Specifies the size of the swap file on each node in MB.
 - `transparent_huge_page_defrag` - (Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are `always`, `defer`, `defer+madvise`, `madvise` and `never`.
 - `transparent_huge_page_enabled` - (Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are `always`, `madvise` and `never`.

 ---
 `sysctl_config` block supports the following:
 - `fs_aio_max_nr` - (Optional) The sysctl setting fs.aio-max-nr. Must be between `65536` and `6553500`.
 - `fs_file_max` - (Optional) The sysctl setting fs.file-max. Must be between `8192` and `12000500`.
 - `fs_inotify_max_user_watches` - (Optional) The sysctl setting fs.inotify.max_user_watches. Must be between `781250` and `2097152`.
 - `fs_nr_open` - (Optional) The sysctl setting fs.nr_open. Must be between `8192` and `20000500`.
 - `kernel_threads_max` - (Optional) The sysctl setting kernel.threads-max. Must be between `20` and `513785`.
 - `net_core_netdev_max_backlog` - (Optional) The sysctl setting net.core.netdev_max_backlog. Must be between `1000` and `3240000`.
 - `net_core_optmem_max` - (Optional) The sysctl setting net.core.optmem_max. Must be between `20480` and `4194304`.
 - `net_core_rmem_default` - (Optional) The sysctl setting net.core.rmem_default. Must be between `212992` and `134217728`.
 - `net_core_rmem_max` - (Optional) The sysctl setting net.core.rmem_max. Must be between `212992` and `134217728`.
 - `net_core_somaxconn` - (Optional) The sysctl setting net.core.somaxconn. Must be between `4096` and `3240000`.
 - `net_core_wmem_default` - (Optional) The sysctl setting net.core.wmem_default. Must be between `212992` and `134217728`.
 - `net_core_wmem_max` - (Optional) The sysctl setting net.core.wmem_max. Must be between `212992` and `134217728`.
 - `net_ipv4_ip_local_port_range_max` - (Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between `32768` and `65535`.
 - `net_ipv4_ip_local_port_range_min` - (Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between `1024` and `60999`.
 - `net_ipv4_neigh_default_gc_thresh1` - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between `128` and `80000`.
 - `net_ipv4_neigh_default_gc_thresh2` - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between `512` and `90000`.
 - `net_ipv4_neigh_default_gc_thresh3` - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between `1024` and `100000`.
 - `net_ipv4_tcp_fin_timeout` - (Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between `5` and `120`.
 - `net_ipv4_tcp_keepalive_intvl` - (Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between `10` and `90`.
 - `net_ipv4_tcp_keepalive_probes` - (Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between `1` and `15`.
 - `net_ipv4_tcp_keepalive_time` - (Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between `30` and `432000`.
 - `net_ipv4_tcp_max_syn_backlog` - (Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between `128` and `3240000`.
 - `net_ipv4_tcp_max_tw_buckets` - (Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between `8000` and `1440000`.
 - `net_ipv4_tcp_tw_reuse` - (Optional) The sysctl setting net.ipv4.tcp_tw_reuse.
 - `net_netfilter_nf_conntrack_buckets` - (Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between `65536` and `524288`.
 - `net_netfilter_nf_conntrack_max` - (Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between `131072` and `2097152`.
 - `vm_max_map_count` - (Optional) The sysctl setting vm.max_map_count. Must be between `65530` and `262144`.
 - `vm_swappiness` - (Optional) The sysctl setting vm.swappiness. Must be between `0` and `100`.
 - `vm_vfs_cache_pressure` - (Optional) The sysctl setting vm.vfs_cache_pressure. Must be between `0` and `100`.

 ---
 `node_network_profile` block supports the following:
 - `application_security_group_ids` - (Optional) A list of Application Security Group IDs which should be associated with this Node Pool.
 - `node_public_ip_tags` - (Optional) Specifies a mapping of tags to the instance-level public IPs. Changing this forces a new resource to be created.

 ---
 `allowed_host_ports` block supports the following:
 - `port_end` - (Optional) Specifies the end of the port range.
 - `port_start` - (Optional) Specifies the start of the port range.
 - `protocol` - (Optional) Specifies the protocol of the port range. Possible values are `TCP` and `UDP`.

 ---
 `upgrade_settings` block supports the following:
 - `drain_timeout_in_minutes` - (Optional) The amount of time in minutes to wait on eviction of pods and graceful termination per node. This eviction wait time honors pod disruption budgets for upgrades. If this time is exceeded, the upgrade fails. Unsetting this after configuring it will force a new resource to be created.
 - `max_surge` - (Required) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade.
 - `node_soak_duration_in_minutes` - (Optional) The amount of time in minutes to wait after draining a node and before reimaging and moving on to next node. Defaults to `0`.
EOT
  nullable    = false
}

variable "kubernetes_cluster_location" {
  type        = string
  description = "(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
  nullable    = false
}

variable "kubernetes_cluster_name" {
  type        = string
  description = "(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  nullable    = false
}

variable "kubernetes_cluster_resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
  nullable    = false
}

variable "kubernetes_cluster_aci_connector_linux" {
  type = object({
    subnet_name = string
  })
  default     = null
  description = <<-EOT
 - `subnet_name` - (Required) The subnet name for the virtual nodes to run.
EOT
}

variable "kubernetes_cluster_api_server_access_profile" {
  type = object({
    authorized_ip_ranges     = optional(set(string))
    subnet_id                = optional(string)
    vnet_integration_enabled = optional(bool)
  })
  default     = null
  description = <<-EOT
 - `authorized_ip_ranges` - (Optional) Set of authorized IP ranges to allow access to API server, e.g. ["198.51.100.0/24"].
 - `subnet_id` - (Optional) The ID of the Subnet where the API server endpoint is delegated to.
 - `vnet_integration_enabled` - (Optional) Should API Server VNet Integration be enabled? For more details please visit [Use API Server VNet Integration](https://learn.microsoft.com/en-us/azure/aks/api-server-vnet-integration).
EOT
}

variable "kubernetes_cluster_api_server_authorized_ip_ranges" {
  type    = set(string)
  default = null
}

variable "kubernetes_cluster_auto_scaler_profile" {
  type = object({
    balance_similar_node_groups      = optional(bool)
    empty_bulk_delete_max            = optional(string)
    expander                         = optional(string)
    max_graceful_termination_sec     = optional(string)
    max_node_provisioning_time       = optional(string)
    max_unready_nodes                = optional(number)
    max_unready_percentage           = optional(number)
    new_pod_scale_up_delay           = optional(string)
    scale_down_delay_after_add       = optional(string)
    scale_down_delay_after_delete    = optional(string)
    scale_down_delay_after_failure   = optional(string)
    scale_down_unneeded              = optional(string)
    scale_down_unready               = optional(string)
    scale_down_utilization_threshold = optional(string)
    scan_interval                    = optional(string)
    skip_nodes_with_local_storage    = optional(bool)
    skip_nodes_with_system_pods      = optional(bool)
  })
  default     = null
  description = <<-EOT
 - `balance_similar_node_groups` - (Optional) Detect similar node groups and balance the number of nodes between them. Defaults to `false`.
 - `empty_bulk_delete_max` - (Optional) Maximum number of empty nodes that can be deleted at the same time. Defaults to `10`.
 - `expander` - (Optional) Expander to use. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `random`.
 - `max_graceful_termination_sec` - (Optional) Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to `600`.
 - `max_node_provisioning_time` - (Optional) Maximum time the autoscaler waits for a node to be provisioned. Defaults to `15m`.
 - `max_unready_nodes` - (Optional) Maximum Number of allowed unready nodes. Defaults to `3`.
 - `max_unready_percentage` - (Optional) Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to `45`.
 - `new_pod_scale_up_delay` - (Optional) For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to `10s`.
 - `scale_down_delay_after_add` - (Optional) How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to `10m`.
 - `scale_down_delay_after_delete` - (Optional) How long after node deletion that scale down evaluation resumes. Defaults to the value used for `scan_interval`.
 - `scale_down_delay_after_failure` - (Optional) How long after scale down failure that scale down evaluation resumes. Defaults to `3m`.
 - `scale_down_unneeded` - (Optional) How long a node should be unneeded before it is eligible for scale down. Defaults to `10m`.
 - `scale_down_unready` - (Optional) How long an unready node should be unneeded before it is eligible for scale down. Defaults to `20m`.
 - `scale_down_utilization_threshold` - (Optional) Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to `0.5`.
 - `scan_interval` - (Optional) How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to `10s`.
 - `skip_nodes_with_local_storage` - (Optional) If `true` cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to `true`.
 - `skip_nodes_with_system_pods` - (Optional) If `true` cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to `true`.
EOT
}

variable "kubernetes_cluster_automatic_channel_upgrade" {
  type        = string
  default     = null
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are `patch`, `rapid`, `node-image` and `stable`. Omitting this field sets this value to `none`."
}

variable "kubernetes_cluster_azure_active_directory_role_based_access_control" {
  type = object({
    admin_group_object_ids = optional(list(string))
    azure_rbac_enabled     = optional(bool)
    client_app_id          = optional(string)
    managed                = optional(bool)
    server_app_id          = optional(string)
    server_app_secret      = optional(string)
    tenant_id              = optional(string)
  })
  default     = null
  description = <<-EOT
 - `admin_group_object_ids` - (Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster.
 - `azure_rbac_enabled` - (Optional) Is Role Based Access Control based on Azure AD enabled?
 - `client_app_id` - 
 - `managed` - (Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration. Defaults to `false`.
 - `server_app_id` - 
 - `server_app_secret` - 
 - `tenant_id` - (Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used.
EOT
}

variable "kubernetes_cluster_azure_policy_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details please visit [Understand Azure Policy for Azure Kubernetes Service](https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks)"
}

variable "kubernetes_cluster_confidential_computing" {
  type = object({
    sgx_quote_helper_enabled = bool
  })
  default     = null
  description = <<-EOT
 - `sgx_quote_helper_enabled` - (Required) Should the SGX quote helper be enabled?
EOT
}

variable "kubernetes_cluster_cost_analysis_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should cost analysis be enabled for this Kubernetes Cluster? Defaults to `false`. The `sku_tier` must be set to `Standard` or `Premium` to enable this feature. Enabling this will add Kubernetes Namespace and Deployment details to the Cost Analysis views in the Azure portal."
}

variable "kubernetes_cluster_custom_ca_trust_certificates_base64" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of up to 10 base64 encoded CAs that will be added to the trust store on nodes with the `custom_ca_trust_enabled` feature enabled."
}

variable "kubernetes_cluster_disk_encryption_set_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys). Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_dns_prefix" {
  type        = string
  default     = null
  description = "(Optional) DNS prefix specified when creating the managed cluster. Possible values must begin and end with a letter or number, contain only letters, numbers, and hyphens and be between 1 and 54 characters in length. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_dns_prefix_private_cluster" {
  type        = string
  default     = null
  description = "(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_edge_zone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_enable_pod_security_policy" {
  type    = bool
  default = null
}

variable "kubernetes_cluster_http_application_routing_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should HTTP Application Routing be enabled?"
}

variable "kubernetes_cluster_http_proxy_config" {
  type = object({
    http_proxy  = optional(string)
    https_proxy = optional(string)
    no_proxy    = optional(set(string))
    trusted_ca  = optional(string)
  })
  default     = null
  description = <<-EOT
 - `http_proxy` - (Optional) The proxy address to be used when communicating over HTTP.
 - `https_proxy` - (Optional) The proxy address to be used when communicating over HTTPS.
 - `no_proxy` - (Optional) The list of domains that will not use the proxy for communication.
 - `trusted_ca` - (Optional) The base64 encoded alternative CA certificate content in PEM format.
EOT
}

variable "kubernetes_cluster_identity" {
  type = object({
    identity_ids = optional(set(string))
    type         = string
  })
  default     = null
  description = <<-EOT
 - `identity_ids` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster.
 - `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are `SystemAssigned` or `UserAssigned`.
EOT
}

variable "kubernetes_cluster_image_cleaner_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Specifies whether Image Cleaner is enabled."
}

variable "kubernetes_cluster_image_cleaner_interval_hours" {
  type        = number
  default     = null
  description = "(Optional) Specifies the interval in hours when images should be cleaned up. Defaults to `48`."
}

variable "kubernetes_cluster_ingress_application_gateway" {
  type = object({
    gateway_id   = optional(string)
    gateway_name = optional(string)
    subnet_cidr  = optional(string)
    subnet_id    = optional(string)
  })
  default     = null
  description = <<-EOT
 - `gateway_id` - (Optional) The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-existing) page for further details.
 - `gateway_name` - (Optional) The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new) page for further details.
 - `subnet_cidr` - (Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new) page for further details.
 - `subnet_id` - (Optional) The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new) page for further details.
EOT
}

variable "kubernetes_cluster_key_management_service" {
  type = object({
    key_vault_key_id         = string
    key_vault_network_access = optional(string)
  })
  default     = null
  description = <<-EOT
 - `key_vault_key_id` - (Required) Identifier of Azure Key Vault key. See [key identifier format](https://learn.microsoft.com/en-us/azure/key-vault/general/about-keys-secrets-certificates#vault-name-and-object-name) for more details.
 - `key_vault_network_access` - (Optional) Network access of the key vault Network access of key vault. The possible values are `Public` and `Private`. `Public` means the key vault allows public access from all networks. `Private` means the key vault disables public access and enables private link. Defaults to `Public`.
EOT
}

variable "kubernetes_cluster_key_vault_secrets_provider" {
  type = object({
    secret_rotation_enabled  = optional(bool)
    secret_rotation_interval = optional(string)
  })
  default     = null
  description = <<-EOT
 - `secret_rotation_enabled` - (Optional) Should the secret store CSI driver on the AKS cluster be enabled?
 - `secret_rotation_interval` - (Optional) The interval to poll for secret rotation. This attribute is only set when `secret_rotation` is true. Defaults to `2m`.
EOT
}

variable "kubernetes_cluster_kubelet_identity" {
  type = object({
    client_id                 = optional(string)
    object_id                 = optional(string)
    user_assigned_identity_id = optional(string)
  })
  default     = null
  description = <<-EOT
 - `client_id` - (Optional) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically. Changing this forces a new resource to be created.
 - `object_id` - (Optional) The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically. Changing this forces a new resource to be created.
 - `user_assigned_identity_id` - (Optional) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically. Changing this forces a new resource to be created.
EOT
}

variable "kubernetes_cluster_kubernetes_version" {
  type        = string
  default     = null
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as `1.22` are also supported."
}

variable "kubernetes_cluster_linux_profile" {
  type = object({
    admin_username = string
    ssh_key = object({
      key_data = string
    })
  })
  default     = null
  description = <<-EOT
 - `admin_username` - (Required) The Admin Username for the Cluster. Changing this forces a new resource to be created.

 ---
 `ssh_key` block supports the following:
 - `key_data` - (Required) The Public SSH Key used to access the cluster.
EOT
}

variable "kubernetes_cluster_local_account_disabled" {
  type        = bool
  default     = null
  description = "(Optional) If `true` local accounts will be disabled. See [the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts) for more information."
}

variable "kubernetes_cluster_maintenance_window" {
  type = object({
    allowed = optional(set(object({
      day   = string
      hours = set(number)
    })))
    not_allowed = optional(set(object({
      end   = string
      start = string
    })))
  })
  default     = null
  description = <<-EOT

 ---
 `allowed` block supports the following:
 - `day` - (Required) A day in a week. Possible values are `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` and `Saturday`.
 - `hours` - (Required) An array of hour slots in a day. For example, specifying `1` will allow maintenance from 1:00am to 2:00am. Specifying `1`, `2` will allow maintenance from 1:00am to 3:00m. Possible values are between `0` and `23`.

 ---
 `not_allowed` block supports the following:
 - `end` - (Required) The end of a time span, formatted as an RFC3339 string.
 - `start` - (Required) The start of a time span, formatted as an RFC3339 string.
EOT
}

variable "kubernetes_cluster_maintenance_window_auto_upgrade" {
  type = object({
    day_of_month = optional(number)
    day_of_week  = optional(string)
    duration     = number
    frequency    = string
    interval     = number
    start_date   = optional(string)
    start_time   = optional(string)
    utc_offset   = optional(string)
    week_index   = optional(string)
    not_allowed = optional(set(object({
      end   = string
      start = string
    })))
  })
  default     = null
  description = <<-EOT
 - `day_of_month` - (Optional) The day of the month for the maintenance run. Required in combination with AbsoluteMonthly frequency. Value between 0 and 31 (inclusive).
 - `day_of_week` - (Optional) The day of the week for the maintenance run. Required in combination with weekly frequency. Possible values are `Friday`, `Monday`, `Saturday`, `Sunday`, `Thursday`, `Tuesday` and `Wednesday`.
 - `duration` - (Required) The duration of the window for maintenance to run in hours. Possible options are between `4` to `24`.
 - `frequency` - (Required) Frequency of maintenance. Possible options are `Weekly`, `AbsoluteMonthly` and `RelativeMonthly`.
 - `interval` - (Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
 - `start_date` - (Optional) The date on which the maintenance window begins to take effect.
 - `start_time` - (Optional) The time for maintenance to begin, based on the timezone determined by `utc_offset`. Format is `HH:mm`.
 - `utc_offset` - (Optional) Used to determine the timezone for cluster maintenance.
 - `week_index` - (Optional) Specifies on which instance of the allowed days specified in `day_of_week` the maintenance occurs. Options are `First`, `Second`, `Third`, `Fourth`, and `Last`. Required in combination with relative monthly frequency.

 ---
 `not_allowed` block supports the following:
 - `end` - (Required) The end of a time span, formatted as an RFC3339 string.
 - `start` - (Required) The start of a time span, formatted as an RFC3339 string.
EOT
}

variable "kubernetes_cluster_maintenance_window_node_os" {
  type = object({
    day_of_month = optional(number)
    day_of_week  = optional(string)
    duration     = number
    frequency    = string
    interval     = number
    start_date   = optional(string)
    start_time   = optional(string)
    utc_offset   = optional(string)
    week_index   = optional(string)
    not_allowed = optional(set(object({
      end   = string
      start = string
    })))
  })
  default     = null
  description = <<-EOT
 - `day_of_month` - (Optional) The day of the month for the maintenance run. Required in combination with AbsoluteMonthly frequency. Value between 0 and 31 (inclusive).
 - `day_of_week` - (Optional) The day of the week for the maintenance run. Required in combination with weekly frequency. Possible values are `Friday`, `Monday`, `Saturday`, `Sunday`, `Thursday`, `Tuesday` and `Wednesday`.
 - `duration` - (Required) The duration of the window for maintenance to run in hours. Possible options are between `4` to `24`.
 - `frequency` - (Required) Frequency of maintenance. Possible options are `Daily`, `Weekly`, `AbsoluteMonthly` and `RelativeMonthly`.
 - `interval` - (Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
 - `start_date` - (Optional) The date on which the maintenance window begins to take effect.
 - `start_time` - (Optional) The time for maintenance to begin, based on the timezone determined by `utc_offset`. Format is `HH:mm`.
 - `utc_offset` - (Optional) Used to determine the timezone for cluster maintenance.
 - `week_index` - (Optional) The week in the month used for the maintenance run. Options are `First`, `Second`, `Third`, `Fourth`, and `Last`.

 ---
 `not_allowed` block supports the following:
 - `end` - (Required) The end of a time span, formatted as an RFC3339 string.
 - `start` - (Required) The start of a time span, formatted as an RFC3339 string.
EOT
}

variable "kubernetes_cluster_microsoft_defender" {
  type = object({
    log_analytics_workspace_id = string
  })
  default     = null
  description = <<-EOT
 - `log_analytics_workspace_id` - (Required) Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to.
EOT
}

variable "kubernetes_cluster_monitor_metrics" {
  type = object({
    annotations_allowed = optional(string)
    labels_allowed      = optional(string)
  })
  default     = null
  description = <<-EOT
 - `annotations_allowed` - (Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.
 - `labels_allowed` - (Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.
EOT
}

variable "kubernetes_cluster_network_profile" {
  type = object({
    dns_service_ip          = optional(string)
    docker_bridge_cidr      = optional(string)
    ebpf_data_plane         = optional(string)
    ip_versions             = optional(list(string))
    load_balancer_sku       = optional(string)
    network_data_plane      = optional(string)
    network_mode            = optional(string)
    network_plugin          = string
    network_plugin_mode     = optional(string)
    network_policy          = optional(string)
    outbound_ip_address_ids = optional(set(string))
    outbound_ip_prefix_ids  = optional(set(string))
    outbound_type           = optional(string)
    pod_cidr                = optional(string)
    pod_cidrs               = optional(list(string))
    service_cidr            = optional(string)
    service_cidrs           = optional(list(string))
    load_balancer_profile = optional(object({
      idle_timeout_in_minutes     = optional(number)
      managed_outbound_ip_count   = optional(number)
      managed_outbound_ipv6_count = optional(number)
      outbound_ip_address_ids     = optional(set(string))
      outbound_ip_prefix_ids      = optional(set(string))
      outbound_ports_allocated    = optional(number)
    }))
    nat_gateway_profile = optional(object({
      idle_timeout_in_minutes   = optional(number)
      managed_outbound_ip_count = optional(number)
    }))
  })
  default     = null
  description = <<-EOT
 - `dns_service_ip` - (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
 - `docker_bridge_cidr` - (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.
 - `ebpf_data_plane` - 
 - `ip_versions` - (Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are `IPv4` and/or `IPv6`. `IPv4` must always be specified. Changing this forces a new resource to be created.
 - `load_balancer_sku` - (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are `basic` and `standard`. Defaults to `standard`. Changing this forces a new resource to be created.
 - `network_data_plane` - (Optional) Specifies the data plane used for building the Kubernetes network. Possible values are `azure` and `cilium`. Defaults to `azure`. Disabling this forces a new resource to be created.
 - `network_mode` - (Optional) Network mode to be used with Azure CNI. Possible values are `bridge` and `transparent`. Changing this forces a new resource to be created.
 - `network_plugin` - (Required) Network plugin to use for networking. Currently supported values are `azure`, `kubenet` and `none`. Changing this forces a new resource to be created.
 - `network_plugin_mode` - (Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is `overlay`.
 - `network_policy` - (Optional) Sets up network policy to be used with Azure CNI. [Network policy allows us to control the traffic flow between pods](https://docs.microsoft.com/azure/aks/use-network-policies). Currently supported values are `calico`, `azure` and `cilium`.
 - `outbound_ip_address_ids` - 
 - `outbound_ip_prefix_ids` - 
 - `outbound_type` - (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are `loadBalancer`, `userDefinedRouting`, `managedNATGateway` and `userAssignedNATGateway`. Defaults to `loadBalancer`. More information on supported migration paths for `outbound_type` can be found in [this documentation](https://learn.microsoft.com/azure/aks/egress-outboundtype#updating-outboundtype-after-cluster-creation).
 - `pod_cidr` - (Optional) The CIDR to use for pod IP addresses. This field can only be set when `network_plugin` is set to `kubenet` or `network_plugin_mode` is set to `overlay`. Changing this forces a new resource to be created.
 - `pod_cidrs` - (Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
 - `service_cidr` - (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created.
 - `service_cidrs` - (Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.

 ---
 `load_balancer_profile` block supports the following:
 - `idle_timeout_in_minutes` - (Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `100` inclusive. Defaults to `30`.
 - `managed_outbound_ip_count` - (Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100` inclusive.
 - `managed_outbound_ipv6_count` - (Optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer. Must be in the range of 1 to 100 (inclusive). The default value is 0 for single-stack and 1 for dual-stack.
 - `outbound_ip_address_ids` - (Optional) The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer.
 - `outbound_ip_prefix_ids` - (Optional) The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer.
 - `outbound_ports_allocated` - (Optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between `0` and `64000` inclusive. Defaults to `0`.

 ---
 `nat_gateway_profile` block supports the following:
 - `idle_timeout_in_minutes` - (Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `120` inclusive. Defaults to `4`.
 - `managed_outbound_ip_count` - (Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100` inclusive.
EOT
}

variable "kubernetes_cluster_node_os_channel_upgrade" {
  type        = string
  default     = null
  description = "(Optional) The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are `Unmanaged`, `SecurityPatch`, `NodeImage` and `None`."
}

variable "kubernetes_cluster_node_resource_group" {
  type        = string
  default     = null
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_oidc_issuer_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Enable or Disable the [OIDC issuer URL](https://learn.microsoft.com/en-gb/azure/aks/use-oidc-issuer)"
}

variable "kubernetes_cluster_oms_agent" {
  type = object({
    log_analytics_workspace_id      = string
    msi_auth_for_monitoring_enabled = optional(bool)
  })
  default     = null
  description = <<-EOT
 - `log_analytics_workspace_id` - (Required) The ID of the Log Analytics Workspace which the OMS Agent should send data to.
 - `msi_auth_for_monitoring_enabled` - (Optional) Is managed identity authentication for monitoring enabled?
EOT
}

variable "kubernetes_cluster_open_service_mesh_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Is Open Service Mesh enabled? For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about)."
}

variable "kubernetes_cluster_private_cluster_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to `false`. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_private_cluster_public_fqdn_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to `false`."
}

variable "kubernetes_cluster_private_dns_zone_id" {
  type        = string
  default     = null
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, `System` to have AKS manage this or `None`. In case of `None` you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_public_network_access_enabled" {
  type    = bool
  default = null
}

variable "kubernetes_cluster_role_based_access_control_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to `true`. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_run_command_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Whether to enable run command for the cluster or not. Defaults to `true`."
}

variable "kubernetes_cluster_service_mesh_profile" {
  type = object({
    external_ingress_gateway_enabled = optional(bool)
    internal_ingress_gateway_enabled = optional(bool)
    mode                             = string
    certificate_authority = optional(object({
      cert_chain_object_name = string
      cert_object_name       = string
      key_object_name        = string
      key_vault_id           = string
      root_cert_object_name  = string
    }))
  })
  default     = null
  description = <<-EOT
 - `external_ingress_gateway_enabled` - (Optional) Is Istio External Ingress Gateway enabled?
 - `internal_ingress_gateway_enabled` - (Optional) Is Istio Internal Ingress Gateway enabled?
 - `mode` - (Required) The mode of the service mesh. Possible value is `Istio`.

 ---
 `certificate_authority` block supports the following:
 - `cert_chain_object_name` - (Required) The certificate chain object name in Azure Key Vault.
 - `cert_object_name` - (Required) The intermediate certificate object name in Azure Key Vault.
 - `key_object_name` - (Required) The intermediate certificate private key object name in Azure Key Vault.
 - `key_vault_id` - (Required) The resource ID of the Key Vault.
 - `root_cert_object_name` - (Required) The root certificate object name in Azure Key Vault.
EOT
}

variable "kubernetes_cluster_service_principal" {
  type = object({
    client_id     = string
    client_secret = string
  })
  default     = null
  description = <<-EOT
 - `client_id` - (Required) The Client ID for the Service Principal.
 - `client_secret` - (Required) The Client Secret for the Service Principal.
EOT
}

variable "kubernetes_cluster_sku_tier" {
  type        = string
  default     = null
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are `Free`, `Standard` (which includes the Uptime SLA) and `Premium`. Defaults to `Free`."
}

variable "kubernetes_cluster_storage_profile" {
  type = object({
    blob_driver_enabled         = optional(bool)
    disk_driver_enabled         = optional(bool)
    disk_driver_version         = optional(string)
    file_driver_enabled         = optional(bool)
    snapshot_controller_enabled = optional(bool)
  })
  default     = null
  description = <<-EOT
 - `blob_driver_enabled` - (Optional) Is the Blob CSI driver enabled? Defaults to `false`.
 - `disk_driver_enabled` - (Optional) Is the Disk CSI driver enabled? Defaults to `true`.
 - `disk_driver_version` - (Optional) Disk CSI Driver version to be used. Possible values are `v1` and `v2`. Defaults to `v1`.
 - `file_driver_enabled` - (Optional) Is the File CSI driver enabled? Defaults to `true`.
 - `snapshot_controller_enabled` - (Optional) Is the Snapshot Controller enabled? Defaults to `true`.
EOT
}

variable "kubernetes_cluster_support_plan" {
  type        = string
  default     = null
  description = "(Optional) Specifies the support plan which should be used for this Kubernetes Cluster. Possible values are `KubernetesOfficial` and `AKSLongTermSupport`. Defaults to `KubernetesOfficial`."
}

variable "kubernetes_cluster_tags" {
  type        = map(string)
  default     = null
  description = "(Optional) A mapping of tags to assign to the resource."
}

variable "kubernetes_cluster_timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<-EOT
 - `create` - (Defaults to 90 minutes) Used when creating the Kubernetes Cluster.
 - `delete` - (Defaults to 90 minutes) Used when deleting the Kubernetes Cluster.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Kubernetes Cluster.
 - `update` - (Defaults to 90 minutes) Used when updating the Kubernetes Cluster.
EOT
}

variable "kubernetes_cluster_web_app_routing" {
  type = object({
    dns_zone_id  = optional(string)
    dns_zone_ids = optional(list(string))
  })
  default     = null
  description = <<-EOT
 - `dns_zone_id` - 
 - `dns_zone_ids` - (Required) Specifies the list of the DNS Zone IDs in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled. If not using Bring-Your-Own DNS zones this property should be set to an empty list.
EOT
}

variable "kubernetes_cluster_windows_profile" {
  type = object({
    admin_password = optional(string)
    admin_username = string
    license        = optional(string)
    gmsa = optional(object({
      dns_server  = string
      root_domain = string
    }))
  })
  default     = null
  description = <<-EOT
 - `admin_password` - (Optional) The Admin Password for Windows VMs. Length must be between 14 and 123 characters.
 - `admin_username` - (Required) The Admin Username for Windows VMs. Changing this forces a new resource to be created.
 - `license` - (Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is `Windows_Server`.

 ---
 `gmsa` block supports the following:
 - `dns_server` - (Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
 - `root_domain` - (Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
EOT
}

variable "kubernetes_cluster_workload_autoscaler_profile" {
  type = object({
    keda_enabled                    = optional(bool)
    vertical_pod_autoscaler_enabled = optional(bool)
  })
  default     = null
  description = <<-EOT
 - `keda_enabled` - (Optional) Specifies whether KEDA Autoscaler can be used for workloads.
 - `vertical_pod_autoscaler_enabled` - (Optional) Specifies whether Vertical Pod Autoscaler should be enabled.
EOT
}

variable "kubernetes_cluster_workload_identity_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to `false`."
}
