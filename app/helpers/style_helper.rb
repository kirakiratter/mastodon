# frozen_string_literal: true

module StyleHelper
  def stylesheet_for_layout
    theme_path = "themes/#{site_theme_for_user}/application.css"

    if asset_exist?(theme_path)
      theme_path
    elsif asset_exist? 'custom.css'
      'custom'
    else
      'application'
    end
  end

  def site_theme_for_user
    current_account&.user&.setting_site_theme || Setting.site_theme
  end

  THEME_COLORS = {
    'default' => '#282c37',
    'kkt' => '#fc217d'
  }.freeze

  # For Android tab color
  def theme_color_for_user
    THEME_COLORS[site_theme_for_user] || THEME_COLORS['default']
  end

  def asset_exist?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end
end
