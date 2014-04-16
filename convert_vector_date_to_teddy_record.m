function record = convert_vector_date_to_teddy_record(date)

record = cell(1,27);

record{bird.SECONDS} = date(1);
record{bird.MINUTES} = date(2);
record{bird.HOURS} = date(3);
record{bird.DAY} = date(4);
record{bird.MONTH} = date(5);
record{bird.YEAR} = date(6);

end