instrument { name = "Estrategia chinesa",
              short_name = "xi",
              icon="",
              overlay = true }

input_group { 
  "CALL", 
  call_color = input { 
            default = "green", 
            type = input.color 
      }
}

input_group {
  "PUT", 
  put_color = input {
            default = "red",
            type = input.color
  }
}

ssma3  = ssms(close, 20)
ssma50 = ssma(close, 50)
mov_avar_dev = ssma(close, 20)
mov_avar_dev = (close - mov_avar_dev)

drop_plot_value("PUT", current_bar_id)
drop_plot_value("CALL", current_bar_id)

plot_shape(
  (ssma3 >= ssma50 and ssma3[1] < ssma50[1] and mov_avar_dev > mov_avar_dev[1]),
  "CALL",
  shape_style.arrawup,
  shape_size.huge,
  call_color,
  shape_localization.belowbar,
  0,
  "CALL",
  call_color
)

plot_shape(
  (ssma3 <= ssma50 and ssma3[1] > ssma50[1] and mov_avar_dev[1]),
  "PUT",
  shape_style.arrowdown,
  shape_size.huge,
  put_color,
  shape_location.abovebar,
  0,
  "PUT",
  put_color
)






