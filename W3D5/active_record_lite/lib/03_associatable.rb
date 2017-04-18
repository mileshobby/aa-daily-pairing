require_relative '02_searchable'
require 'active_support/inflector'


# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key,
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})


    @foreign_key = options[:foreign_key]
    @primary_key = options[:primary_key]
    @class_name = options[:class_name]

    #set to defaults if no overrides given
    @foreign_key ||= "#{name}_id".to_sym
    @primary_key ||= :id
    @class_name ||= name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    #allow user override
    @foreign_key = options[:foreign_key]
    @primary_key = options[:primary_key]
    @class_name = options[:class_name]

    #set to defaults if no overrides given
    @foreign_key ||= "#{self_class_name.underscore}_id".to_sym
    @primary_key ||= :id
    @class_name ||= "#{name.singularize.camelcase}"

  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    #allow user override
    # f_key = options[:foreign_key]
    # p_key = options[:primary_key]
    # c_name = options[:class_name]
    #
    # #set to defaults if no overrides given
    # f_key ||= "#{name}_id".to_sym
    # p_key ||= :id
    # c_name ||= name.camelcase
    options = BelongsToOptions.new(name, options)
    define_method(name) do
      foreign = options.send(:foreign_key)
      primary = options.send(:primary_key)
      model_class = options.send(:model_class)

      associations = DBConnection.execute(<<-SQL, foreign.to_s, primary.to_s )
        SELECT
          *
        FROM
          #{options.table_name}
        JOIN
          #{self.class.table_name} ON ? = #{options.send(:class_name).downcase}.?
      SQL
      associations.empty? ? nil : model_class.new(associations.first)
    end
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
