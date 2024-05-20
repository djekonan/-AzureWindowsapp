
resource "azurerm_service_plan" "konanserverappexample" {
  for_each            = {for windowappserver in local.window_app_list : "${windowappserver.name}" => windowappserver}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.konanwindowappserver.name
  location            = azurerm_resource_group.myregiswindowappserverrg.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}


resource "azurerm_windows_web_app" "example" {
  for_each            = { for app in local.window_app_list : app.name => app }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.myregiswindowappserverrg.name
  service_plan_id     = azurerm_service_plan.svregiswinserverappexample[each.key].id
  location            = azurerm_service_plan.svregiswinserverappexample[each.key].location

  site_config {}
}
