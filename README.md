# colab-cluster-policy

Use Terraform to create the following resources in a CoLab workspace. 

Note that each CoLab workspace has a corresponding Terraform workspace, and the credentials are stored in `.databrickscfg` using a name of format `colab_{workspace_name}`

It includes the following resources:
1. Instance pool: [photon-small-pool](instance_pool.tf)
2. Cluster policy: [colab_single_node_small](cluster_policy.tf) and its associated permissions
3. Cluster policy: [tpcdi](tpcdo_cluster_policy.tf) and its associated permission

You can use the [generate_databrickscfg.py](generate_databrickscfg.py) to generate `.databrickscfg` based on the [Partner CoLab](https://docs.google.com/spreadsheets/d/1psGBLvYOp8IGptQZmbNYqHrQ57q2Y2HzWoQ24KPwxE4/edit#gid=425125794) spreadsheet

Then use the [plan.sh](plan.sh) and [apply.sh](apply.sh) scripts to create the resources in the workspace.