AttachmentsHandler = function(placeholder_selector, deep) {
  deep = deep || 1;
  // Get the layout to use
  var attachment_layout = placeholder_selector.find(".attachment.new").last();
  var initial_index = placeholder_selector.find(".attachment").length - 1;

  // Detach layout
  if (initial_index > 0) {
    attachment_layout.detach();
  } else {
    attachment_layout = attachment_layout.clone();
    placeholder_selector.find(".attachment.new").last().find('.btn-delete').attr('disabled', 'disabled');
  }

  // Remove layout defining class
  attachment_layout.removeClass("new");

  /*
   Function to get the common part of name attribute
   */
  var getInputCommonName = function(element) {
    var regexp = "^\\w+\\[\\w+(_attributes)]";

    for (var i = 0; i < (deep-1); i++) {
      regexp = regexp + "\\[\\d+\]\\[\\w+(_attributes)\\]";
    }

    return $(element).attr("name").match(new RegExp(regexp))[0];
  };

  /*
   Function to get the common part of id attribute
   */
  var getInputCommonId = function(element) {
    var regexp = "^\\w+_\\w+(_attributes)";

    for (var i = 0; i < (deep-1); i++) {
      regexp = regexp + "_\\d+_\\w+(_attributes)";
    }

    return $(element).attr("id").match(new RegExp(regexp))[1];
  };

  /*
   Function to update name and id in layout's inputs
   */
  var updateAttachmentLayout = function(layout) {
    var new_index = placeholder_selector.find(".attachment").length;

    layout.find("input").each(function(i, element) {
      if ($(element).attr("name") !== undefined) {
        var common_part_name = getInputCommonName(element);
        $(element).attr("name", $(element).attr("name").replace(common_part_name + "[" + initial_index, common_part_name + "[" + new_index));
      }

      if ($(element).attr("id") !== undefined) {
        var common_part_id = getInputCommonId(element);
        $(element).attr("id", $(element).attr("id").replace(common_part_id + "_" + initial_index, common_part_id + "_" + new_index));
      }
    });

    return layout;
  };

  /*
   Create new attachments.
   */
  placeholder_selector.on("click", ".btn-new", function() {
    var new_attachment = updateAttachmentLayout(attachment_layout.clone());
    placeholder_selector.find(".attachments-container").append(new_attachment);
    new_attachment.find("input[type='text']").first().focus();

    placeholder_selector.find(".attachment").find('.btn-delete').removeAttr('disabled');
  });

  /*
   Delete attachments.
   */
  placeholder_selector.on("click", ".btn-delete", function(e) {
    if (placeholder_selector.find(".attachment").length < 2) {
      return;
    }

    var attachment = $(e.target.closest(".attachment"));

    if (attachment.find(".attachment-id").val() !== "") {
      // If persisted, set to destroy and hide the attachment
      attachment.find(".attachment-destroy").val(true);

      attachment.find("*[required]").each(function(i, element) {
        $(element).attr("required", false);
      });

      attachment.hide();
    }
    else {
      attachment.detach();
    }

    if (placeholder_selector.find(".attachment").length == 1) {
      placeholder_selector.find(".attachment").find('.btn-delete').attr('disabled', 'disabled');
    }
  });
};
