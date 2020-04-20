# frozen_string_literal: true

module ThemeHelper
  def site_theme_for_user
    current_user&.account&.user&.setting_theme || Setting.theme
  rescue
    Setting.theme
  end

  THEME_COLORS = {
    'default' => '#df57a4',
    'mastodon' => '#282c37',
    'contrast' => '#282c37',
    'mastodon-light' => '#282c37',
    'kkt' => '#df57a4',
    'kkt-angely' => '#eb9fa9',
    'kkt-dark' => '#1a1a1a',
    'kkt-checkmate' => '#050505'
  }.freeze

  # For Android tab color
  def theme_color_for_user
    THEME_COLORS[site_theme_for_user] || THEME_COLORS['default']
  end
end

