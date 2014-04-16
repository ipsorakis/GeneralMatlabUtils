function d = convert_teddy_record_date_to_vector(record)

d = zeros(1,6);

SECONDS = 1;
MINUTES = 2;
HOURS = 3;
DAY = 4;
MONTH = 5;
YEAR = 6;

if ischar(record{bird.SECONDS})
    d(SECONDS) = str2double(record{bird.SECONDS});
else
    d(SECONDS) = record{bird.SECONDS};
end

if ischar(record{bird.MINUTES})
    d(MINUTES) = str2double(record{bird.MINUTES});
else
    d(MINUTES) = record{bird.MINUTES};
end

if ischar(record{bird.HOURS})
    d(HOURS) = str2double(record{bird.HOURS});
else
    d(HOURS) = record{bird.HOURS};
end

if ischar(record{bird.DAY})
    d(DAY) = str2double(record{bird.DAY});
else
    d(DAY) = record{bird.DAY};
end

if ischar(record{bird.MONTH})
    d(MONTH) = str2double(record{bird.MONTH});
else
    d(MONTH) = record{bird.MONTH};
end

if ischar(record{bird.YEAR})
    d(YEAR) = str2double(record{bird.YEAR});
else
    d(YEAR) = record{bird.YEAR};
end

end