resource "databricks_instance_pool" "photon_small_pool" {
  instance_pool_name = "photon-small-pool"
  min_idle_instances = 0
  max_capacity       = 5
  node_type_id       = "m5d.large"
  preloaded_spark_versions = ["13.0.x-scala2.12"]
  aws_attributes {
    availability           = "SPOT"
    zone_id                = "us-west-2d"
    spot_bid_price_percent = "100"
  }
  idle_instance_autotermination_minutes = 45
  disk_spec {
    disk_type {
      ebs_volume_type = "GENERAL_PURPOSE_SSD"
    }
    disk_size  = 80
    disk_count = 1
  }
}

resource "databricks_permissions" "pool_usage" {
  instance_pool_id = databricks_instance_pool.photon_small_pool.id

  access_control {
    group_name       = "users"
    permission_level = "CAN_ATTACH_TO"
  }
}