json.array!(@user_event) do |event|
  json.extract! event, :id
  json.start event.start
  json.end event.end
  if event.event == 'отпуск'
    json.color 'red'
  elsif event.event == 'отгул'
    json.color 'blue'
  else
    json.color 'green'
  end
end