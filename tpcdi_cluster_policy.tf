locals {
  tpcdi_policy = {
  "spark_conf.spark.databricks.cluster.profile": {
    "type": "fixed",
    "value": "singleNode",
    "hidden": true
  },
"num_workers": {
    "type": "fixed",
    "value": 0,
    "hidden": true
  },
  "docker_image.url": {
    "type": "forbidden",
    "hidden": true
  },
  "dbus_per_hour": {
    "type": "range",
    "maxValue": 4
  }
}
}

resource "databricks_cluster_policy" "tpcdi" {
  name       = "TPC-DI"
  definition = jsonencode(local.tpcdi_policy)
}

resource "databricks_permissions" "tpcdi_can_use_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.tpcdi.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_USE"
  }
}