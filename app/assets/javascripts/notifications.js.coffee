class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")

    if @notifications.length > 0
      @handleSuccess @notifications.data("notifications")
      $("[data-behavior='notifications-link']").on "click", @handleClick

    setInterval (=>
       @getNewNotifications()
     ), 600000 

    @getNewNotifications()

  getNewNotifications: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("[data-behavior='unread-count']").text(0)
    )

  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      notification.template

    unread_count = 0
    $.map data, (i, notification) ->
      if !notification.read_at
        unread_count += 1

    $("[data-behavior='unread-count']").text(unread_count)
    $("[data-behavior='notification-items']").html(items)

jQuery ->
  new Notifications
