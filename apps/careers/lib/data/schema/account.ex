defmodule Careers.Data.Schema.Account do
  use Careers.Schema
  alias Careers.Data.Schema.Profile, as: Profile

    schema "accounts" do
      has_one :profiles, Profile

      field :username, :string
      field :password, :string
      timestamps()
    end


    @create_fields [:username, :password]
    @update_fields [:password]

    def create_fields, do: @create_fields
    def update_fields, do: @update_fields

    def changeset(instance, params, operation \\ :create)

    def changeset(instance, params, :create) do
      do_changeset(instance, params, @create_fields)
    end

    def changeset(instance, params, :update) do
      do_changeset(instance, params, @update_fields)
    end

    defp do_changeset(instance, params, fields) do
      instance
      |> cast(params, fields)
      |> validate_required(fields)
      |> unique_constraint(:username, message: "Username already taken")
      |> validate_length(:password, min: 6)
      |> validate_length(:username, min: 3)
    end
end
