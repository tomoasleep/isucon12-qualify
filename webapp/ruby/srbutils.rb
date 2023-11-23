# typed: true

module StructLike
  extend T::Sig
  extend T::Helpers

  requires_ancestor { T::InexactStruct }

  sig { returns(T::Hash[Symbol, T.untyped]) }
  def to_h
    T.unsafe(self).serialize.to_h { |k, v| [k.to_sym, v] }
  end

  module ClassMethods
    extend T::Sig
    extend T::Generic
    extend T::Helpers

    has_attached_class! { { upper: T.class_of(T::InexactStruct) } }

    sig {
      params(
        hash: T::Hash[T.any(Symbol, String), T.untyped]
      ).returns(
        T.attached_class
      )
    }
    def build(hash = {})
      T.unsafe(self).from_hash(hash.to_h { |k, v| [k.to_s, v] })
    end
  end

  mixes_in_class_methods(ClassMethods)
end
