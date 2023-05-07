locals {
  default_policy = {
  "spark_conf.spark.databricks.cluster.profile": {
    "type": "fixed",
    "value": "singleNode",
    "hidden": true
  },
  "spark_version": {
    "type": "fixed",
    "value": "13.0.x-scala2.12",
    "hidden": true
  },
  "instance_pool_id": {
    "type": "fixed",
    "value": databricks_instance_pool.photon_small_pool.id,
    "hidden": true
  },
  "autotermination_minutes": {
    "type": "fixed",
    "value": 45,
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
    "maxValue": 0.9
  }
}
}

resource "databricks_cluster_policy" "colab_single_node_small" {
  name       = "CoLab Single Node Small Photon"
  definition = jsonencode(local.default_policy)
}


resource "databricks_permissions" "can_use_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.colab_single_node_small.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_USE"
  }
}