def next_weekday_of(date)
  next_date = date.tomorrow
  # NOTE: 平日とは、土・日・祝日いずれでもないものとする
  return next_date unless next_date.sunday? \
                          || next_date.saturday? \
                          || HolidayJp.holiday?(next_date)
  next_weekday_of(next_date)
end
