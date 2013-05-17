# United Attributes

United Attributes is a library for Ruby on Rails that allows you to declare units on numerical attributes in your models and exploit that information for unit conversion and template presentation.

## Why?

Let's consider a duck that weighs 4 kilos. Here is a typical example of how you present a weight attribute of a Duck model in an ERB view.

    <li><%= @duck.weight %> kilos</li>

This makes the view aware of the units in the model, so if you'd rather use stones or pounds, you'll have to update views that display duck weights. An improved version that handles internationalization and pluralization, so slim ducks are not listed as weighing "1 kilos", could be:

    <li><%= @duck.weight %> <%= t('.kilogram', count: @duck.weight) %></li>

Now it prints out nicely, but pollutes the internationalization with a generic unit translation and repeats the duck instance variable and doesn't decouple the view from the attribute unit. You could add a weight_unit to the attribute model and then use that unit for I18n lookup, but still. That's an entire column of presumeably identical attributes in your Duck table.

United Attributes attempts to make views unaware of the units involved, yet still capable of displaying them. And without adding anything to the database.

## Usage

First, declare the units used in your attribute when defining your model. Use the `unite` method.

    class Duck < ActiveRecord::Base
      attr_accessible :name, :weight, :lifespan
      unite :weight, :kilogram, precision: 2
      unite :lifespan, :year
    end

United Attributes will automatically determine the domain(length, area, volume, time, etc...) of the unit by scanning it's bundled unit database for the first unit that matches the declared unit. To avoid theoretical false matches (e.g. a pound being both a weight and currency unit) and improve readability for other developers, you may choose to specifiy the domain explicitly when declaring your units. This will skip the search.

    unite :weight, :pound, domain: :weight, precision: 2

The precision option is for presentation only and determines the amount of decimals shown when calling to_s on an attribute. The option may be modified out in the templates. The default precision is 0.

When using the `unite` declaration, United Attributes will add an additional attribute reader to instances of the model prefixed with `united_`, so in this case Duck has received `united_weight` and `united_lifespan`. Whenever using these two accessors, an instance of `UnitedAttributes::Attribute` will be returned. This allows you to do this:

    <li><%= @duck.united_weight %></li>
    <li><%= @duck.united_lifespan %></li>

Assuming our database record of the duck has a weight of 3.6926 and a lifespan of 4, the following will render:

    <li>3.69 kilograms<li>
    <li>4 years</li>

Because United Attributes is aware of your units, United Attributes has built-in conversion methods that are automatically defined on your UnitedAttributes::Attribute instances upon initialization. This allows you to do

    @duck.united_weight.as_pounds
    => "8.14 pounds"

If we want even more precision, we can do:

    @duck.united_weight.as_pounds.precision(4)
    => "8.1408 pounds"

Keep in mind that attributes are evaluated by calling the default accessor on the first `united_` call, so don't mutate your object after getting an `Attribute` instance, or expect this:

    united_attribute_instance = @duck.united_weight
    @duck.weight = 5
    united_attribute_instance.to_s
    => "3.69 kilograms"
    @duck.united_weight
    => "5.00 kilograms"

If you just want to use the unit converter, but be rid of the formatting, you can use the value method.

    @duck.united_weight.as_pounds.value
    => 8.140789421649316

This will return float. If you call value without a version, you will get whatever value the native accessor, e.g. `@duck.weight` returns. But if you wanted that, why not just call `@duck.weight` instead of going through United Attributes.

## What domains are supported?

United Attributes currently supports common units within the following domains:

- Area (square kilometers, acres, etc.)
- Data (bits and bytes in most denominations - both binary and metric units - mebibyte/megabyte)
- Length (meters, inches)
- Space (liters, cubic units, gallons, pints)
- Speed (kilometers, meters and miles pr. hour and second)
- Time (seconds, minutes, hours, days, weeks, months, years)
    - Caveat: Months and years are not fixed in relation to seconds, so a month is exactly 30,4375 days and a year is exactly 365.25 days. Because the year length divided by the month length is exactly 12, conversion between months and years will work fine.
- Weight (metric units and pounds)

