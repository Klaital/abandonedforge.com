class Product < ApplicationRecord
  # Computes a new height x width string after scaling the thumbnail's width
  # to match the specified height, while keeping the correct aspect ratio.
  def thumbnail_resize(new_height= 32)
    if thumbnail_url.empty? || thumbnail_size.empty?
      return "#{new_height}x#{new_height}"
    end

    dimensions = thumbnail_size.split('x')
    # For a list view, we want a thumbnail with a vertical size of 32px, with the horizontal scaled accordingly.
    scale = dimensions[1].to_f / new_height.to_f
    small_dimensions = dimensions.map {|d| (d.to_i / scale).floor}.join('x')
    logger.debug("Modifying dimensions (#{thumbnail_size}): #{dimensions} / #{scale} = #{small_dimensions}")
    small_dimensions
  end

  def description_shortened(length = 30)
    return description if description.length <= length
    description[0...length] + '...'
  end
end
