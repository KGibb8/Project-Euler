# frozen_string_literal: true

module Repository
  module Relation
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def has_one(association, options = {})
        association_name = association.to_s
        association_class_name = association_name.to_s
        .split("_")
        .map(&:capitalize)
        .join
        primary_association_name = self.name
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .downcase

        self.__send__(:define_method, association_name) do
          association_class = Object.const_get(association_class_name)
          Record::Single.new(association_class.where(primary_association_name.to_sym => self))
        end
      end

      def has_many(association, options = {})
        association_name = association.to_s
        singularized_association_name = association_name.end_with?("s") ? association_name[0..-2] : association_name
        association_class_name = singularized_association_name.to_s
        .split("_")
        .map(&:capitalize)
        .join
        primary_association_name = self.name
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .downcase

        self.__send__(:define_method, association_name) do
          association_class = Object.const_get(association_class_name)
          Record::Collection.new(association_class.where(primary_association_name.to_sym => self))
        end
      end

      def belongs_to(association_name, options = {})
        association_class_name = association_name.to_s
        .split("_")
        .map(&:capitalize)
        .join

        foreign_association_name = self.name
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .downcase

        self.__send__(:define_method, association_name) do
          association_class = Object.const_get(association_class_name)
          association_class.find_by(foreign_association_name => self)
        end
      end
    end
  end
end
