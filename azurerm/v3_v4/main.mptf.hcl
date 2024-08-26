data "resource" all {
}

data "data" all {

}

locals {
  all_resources    = { for obj in flatten([for obj in flatten([for b in data.resource.all.result.* : [for nb in b : nb]]) : [for body in obj : body]]) : obj.mptf.block_address => obj }
  all_data_sources = { for obj in flatten([for obj in flatten([for b in data.data.all.result.* : [for nb in b : nb]]) : [for body in obj : body]]) : obj.mptf.block_address => obj }
}