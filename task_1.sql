-- тип занятости
CREATE TABLE employment_type (
    employment_type_id serial primary key ,
    timetable_type_title text not null
);

-- уровень образования
CREATE TABLE education_type (
    education_type_id serial primary key ,
    education_type_title text not null
);

-- специализации
CREATE TABLE specialization (
    specialization_id serial primary key ,
    specialization_title text not null
);

-- график работы
CREATE TABLE Timetable (
    timetable_id serial primary key ,
    timetable_title text not null 
);

CREATE TABLE area (
    area_id serial primary key ,
    area_title text not null
);

CREATE TABLE Candidate (
    candidate_id serial primary key ,
    first_name text not null ,
    second_name text not null ,
    middle_name text,
    area_id integer not null references area (area_id),
    telephone text,
    education_type_id integer not null references education_type (education_type_id)
);

CREATE TABLE employer (
    employer_id serial primary key ,
    employer_name text not null ,
    area_id integer not null references area (area_id)
);

CREATE TABLE vacancy (
    vacancy_id serial primary key ,
    vacancy_title text not null ,
    employer_id integer not null references employer (employer_id),
    compensation_from integer,
    compensation_to integer,
    compensation_gross bool not null default true,
    employment_type_id integer not null references employment_type (employment_type_id),
    timetable_id integer references timetable (timetable_id),
    date_publication date not null
);

CREATE TABLE resume (
    resume_id serial primary key ,
    resume_title text not null ,
    candidate_id integer not null references candidate (candidate_id),
    salary integer,
    employment_type_id integer references employment_type (employment_type_id),
    date_publication date not null
);

/* отдельная таблица специализации вакансии, т. к. их может быть несколько у одной вакансии.
   Отношение многие-ко-многим */
CREATE TABLE vacancy_specialization (
    vacancy_id integer not null references vacancy (vacancy_id),
    specialization_id integer not null references specialization (specialization_id)
);

/* отдельная таблица специализации резюме, т. к. их может быть несколько у одного резюме.
   Отношение многие-ко-многим */
CREATE TABLE resume_specialization (
    resume_id integer not null references resume (resume_id),
    specialization_id integer not null references specialization (specialization_id)
);

CREATE TABLE response (
    vacancy_id integer not null references vacancy (vacancy_id),
    resume_id integer not null references resume (resume_id),
    date_response date not null
);
