Hipocrates
==========

E-hospital project for [Computer Science in Medicine](http://www.cs.put.poznan.pl/tpawlak/?zastosowania-informatyki-w-medycynie,6) under [MSc Tomasz Pawlak](http://www.cs.put.poznan.pl/tpawlak). Done at PUT.


# [PL] Hipocrates - e-szpital

Projekt zrealizowany w ramach przedmiotu Informatyka w Medycynie prowadzony przez [mgr Tomasza Pawlaka](http://www.cs.put.poznan.pl/tpawlak).

Celem projektu było zrealizowanie aplikacji internetowej pełniącą rolę e-szpitala. Do wykonania zastosowano m.in
+ framework Ruby On Rails
+ bazę danych MongoDB
+ front-end framework Twitter Boostrap
+ bibliotekę Backbone.js
oraz wiele innych.

## Użytkownicy

W projekcie są wydzielone 4 grupy użytkowników (admin ma możliwość stworzenia dodatkowych grup). Możemy wyróżnić:
+ pacjentów
+ pracowników biura
+ lekarzy
+ administatorów

### Pacjent

Podstawowy typ użytkownika (przy rejestracji rola ta nadawana jest automatycznie). Rejestracja pacjenta może odbyć się na jeden z dwóch sposobów:
+ pacjent może samemu się zarejestrować poprze formularz
+ pacjent może zostać zarejestrowany przez pracownika biura bądź lekarza (zostanie mu przydzielony unikalny login)

Zgodnie ze specyfikacją projektu pierwsza z metod wymaga pełnej poprawności danych, druga natomiast jedynie ostrzega przed ich niepoprawnością, lecz pozwala na ich zapis.

Zarejestrowany pacjent ma możlwiwość zgłoszenia prośby o wizytę, gdzie podaje specjalizcję oraz lekarza - prośba musi zostać zatwierdzona przez pracownika biura bądź lekarza.

Ma także pełen wgląd do historii swoich wizyt.

### Pracownik biura

Głównym zadaniem pracownika biura jest potwierdzanie wizyt lekarskich. Na głównym ekranie pracownik biura widzi wizyty oczekujące, które wymagają od niego pewnej akcji. Akcja ta polega na ustaleniu daty wizyty oraz opcjonalnie uzupełnieniu informacji dla lekarza.

Kolejnymi zadaniami pracownika biura jest rejestrowanie pacjentów, którzy nie chcą zrobić tego samemu oraz umawianie ich (oraz już istniejąych pacjentów) na wizyty lekarskie.

### Lekarz

Lekarz jest poniekąd rozszerzeniem pracownika biura - z jedną różnicą - nie ma wglądu do dowolnych wizyt pacjentów, a jedynie tych którzy zapisali się na wizytę do niego. Oprócz tego jego zadaniem uzupełnianie informacji dla pacjentów:
+ notatka
+ rozpoznanie (zgodne z ICD10)
+ przeprowadzone procedury medyczne (ICD9)
+ zapisane leki


### Administrator

Ma pełne uprawnienia. Wykonuje wiele kluczowych zadań takich jak:
+ dodawanie specjalności, leków, rozpoznań i procedur do bazy
+ zmiany roli poszczególnych użytkowników
+ dodawanie nowych ról

## Wizyta

W okół wizyty rozbija się cała idea projektu. Cykl życia wizyty wygląda następująco:
+ pacjent zgłasza chęć umówienia się do lekarza
+ pracownik biura/lekarz ustawia datę wizyty oraz uzupełnia inforacje dla lekarza
+ pacjent otrzymuje potwierdzenie wizyty drogą mailową
+ wizyta lekarska
+ lekarz wprowadza informacje o rozpoznaniu, przeprowadzonych procedurach, zapisanych lekach i informacji dla pacjenta
+ pacjent na maila otrzymuje podsumowanie wizyty

## Modele

### User

Model reprezentujący użytkownika
```ruby
field :password_hash, type: String
field :password_salt, type: String
field :login, type: String
field :name, type: String
field :surname, type: String
field :date_of_birth, type: Date
field :place_of_birth, type: String
field :street, type: String
field :sex, type: String
field :city, type: String
field :postal_code, type: String
field :pesel, type: String
field :id_number, type: String
field :id_serial, type: String
field :phone, type: String
field :nip, type: String
field :email, type: String
field :origin, type: String

embeds_one :relative

belongs_to :role
has_and_belongs_to_many :specialities
has_many :visits, inverse_of: :patient
has_many :appointments, class_name: 'Visit', inverse_of: :doctor
```

### Relative

Krewny pacjenta, występuje tylko i wyłącznie z nim.
```ruby
embedded_in :user

field :name, type: String
field :surname, type: String
field :phone, type: String
```

### Visit

Wizyta lekarska.

```ruby
belongs_to :patient, class_name: 'User', inverse_of: :visits
belongs_to :doctor, class_name: 'User', inverse_of: :appointments
belongs_to :speciality
has_and_belongs_to_many :recognitions
has_and_belongs_to_many :procedures
has_and_belongs_to_many :meds

field :confirmed, type: Boolean, default: false
field :date, type: DateTime
field :reason, type: String
field :note, type: String
field :instructions, type: String
```

### Med

Model odpowiedzialny za leki (dodawane przez administatora).

```ruby
has_and_belongs_to_many :visits

field :name, type: String
field :dose, type: String
field :form, type: String
field :wrapper, type: String
```

### Procedure

Procedury wykonywane przez lekarza podczas wizyty (dodawane przez administratora).

```ruby
has_and_belongs_to_many :visits

field :icd9, type: String
field :name, type: String
```

### Recognition

Rozpoznania podczas wizyty stwierdzone przez lekarza (dodawane przez administratora).

```ruby
has_and_belongs_to_many :visits

field :icd10, type: String
field :name, type: String
```

### Role

Role użytkowników takiej jak pacjent, doktor, pracownik biura czy administrator (dodawane przez administratora).

```ruby
has_many :users
field :name, type: String
```

### Speciality

Specjalizacje lekarskie (dodawane przez administratora).
```ruby
field :name, type: String
field :active, type: Boolean, default: false
has_and_belongs_to_many :users
```

## Uruchomienie

Aby uruchomić projekt należy wykonać standardowe kroki koniecznie do uruchamienia aplikacji RoR oraz utworzyć plik <code>config/secret_config.yml</code> zawierający informacje konieczne do wysyłania powiadomień. Przykładowy plik ma postać:
```yml
domain: 'yourdomain.com'
full_url: 'http://yourdomain.com'
mail:
  smtp_server: 'smtp.youdomain.com'
  port: 587
  user_name: 'your_user_name'
  password: 'secret'
```



