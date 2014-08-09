module AdminsHelper
  def role_to_context(role)
    contexts = %w[danger info success]
    contexts[User::ROLES.index(role)]
  end
end
