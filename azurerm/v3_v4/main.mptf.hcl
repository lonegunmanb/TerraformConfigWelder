data "resource" all {
}

locals {
  all_resources = { for obj in flatten([for obj in flatten([for b in data.resource.all.result.* : [for nb in b : nb]]) : [for body in obj : body]]) : obj.mptf.block_address => obj }
  #                    dot | potential new line | label[1] | potential index or splat | dot | potential new line
}