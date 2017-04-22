# frozen_string_literal: true

module StyleHelper
  def stylesheet_for_user
    theme = current_account.try(:user).try(:setting_site_theme) || Setting.site_theme

    if theme.present? && asset_exist?("themes/#{theme}.css")
      "themes/#{theme}"
    else
      stylesheet_for_layout
    end
  end

  def stylesheet_for_layout
    if asset_exist? 'custom.css'
      'custom'
    else
      'application'
    end
  end

  def asset_exist?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end
end
