unit Cairo_dyn;

(* cairo - a vector graphics library with display and print output
 *
 * Copyright © 2002 University of Southern California
 * Copyright © 2005 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it either under the terms of the GNU Lesser General Public
 * License version 2.1 as published by the Free Software Foundation
 * (the "LGPL") or, at your option, under the terms of the Mozilla
 * Public License Version 1.1 (the "MPL"). If you do not alter this
 * notice, a recipient may use your version of this file under either
 * the MPL or the LGPL.
 *
 * You should have received a copy of the LGPL along with this library
 * in the file COPYING-LGPL-2.1; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * You should have received a copy of the MPL along with this library
 * in the file COPYING-MPL-1.1
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
 * OF ANY KIND, either express or implied. See the LGPL or the MPL for
 * the specific language governing rights and limitations.
 *
 * The Original Code is the cairo graphics library.
 *
 * The Initial Developer of the Original Code is University of Southern
 * California.
 *
 * Contributor(s):
 *  Carl D. Worth <cworth@cworth.org>
 *
 *  This FreePascal binding generated August 26, 2005 
 *  by Jeffrey Pohlmeyer <yetanothergeek@yahoo.com>
 *
 * - Updated to cairo version 1.4
 * - Grouped OS specific fuctions in separated units
 * - Organized the functions by group and ordered exactly as the c header
 * - Cleared parameter list syntax according to pascal standard
 *
 * By Luiz Am?rico Pereira C?mara
 * October 2007
 *
 * - Review of the unit according of cairo.h, cairo-svg.h, 
 *   cairo-pdf.h and cairo-ps.h
 * - Adding structures, enumerations, and methods missing.
 * - Translation and addition of cairo-tee.h, cairo-script.h,
 *   cairo-script-interpreter.h and cairo-gobject.h
 * - Updated to cairo version 1.12
 * By Valdinilson Louren?o da Cunha - November 2012
 * 
*)

// Dynamic loading by Fred vS

{$mode ObjFpc}

interface

uses
  dynlibs,
  CTypes;

const
{$ifdef MSWINDOWS}
  LIB_CAIRO = 'libcairo-2.dll';
  {$IFDEF FPC}
    {$ifndef NO_SMART_LINK}
      {$smartlink on}
    {$endif}
  {$ENDIF}
{$else}
  {$ifdef darwin}
    LIB_CAIRO = 'cairo';
    {$linklib cairo}
  {$else}
    {$ifdef UseCustomLibs}
    LIB_CAIRO = '';
    {$else}
    LIB_CAIRO = 'libcairo.so.2';
    {$endif}
  {$endif}
{$endif}

{$IFDEF FPC}
  {$PACKRECORDS C}
{$ENDIF}

type
  GTYPE = culong; // =gulong from glib2, which we can't include due dependencies.
  cairo_status_t         = (
    CAIRO_STATUS_SUCCESS = 0,

    CAIRO_STATUS_NO_MEMORY,
    CAIRO_STATUS_INVALID_RESTORE,
    CAIRO_STATUS_INVALID_POP_GROUP,
    CAIRO_STATUS_NO_CURRENT_POINT,
    CAIRO_STATUS_INVALID_MATRIX,
    CAIRO_STATUS_INVALID_STATUS,
    CAIRO_STATUS_NULL_POINTER,
    CAIRO_STATUS_INVALID_STRING,
    CAIRO_STATUS_INVALID_PATH_DATA,
    CAIRO_STATUS_READ_ERROR,
    CAIRO_STATUS_WRITE_ERROR,
    CAIRO_STATUS_SURFACE_FINISHED,
    CAIRO_STATUS_SURFACE_TYPE_MISMATCH,
    CAIRO_STATUS_PATTERN_TYPE_MISMATCH,
    CAIRO_STATUS_INVALID_CONTENT,
    CAIRO_STATUS_INVALID_FORMAT,
    CAIRO_STATUS_INVALID_VISUAL,
    CAIRO_STATUS_FILE_NOT_FOUND,
    CAIRO_STATUS_INVALID_DASH,
    CAIRO_STATUS_INVALID_DSC_COMMENT,
    CAIRO_STATUS_INVALID_INDEX,
    CAIRO_STATUS_CLIP_NOT_REPRESENTABLE,
    CAIRO_STATUS_TEMP_FILE_ERROR,
    CAIRO_STATUS_INVALID_STRIDE,
    CAIRO_STATUS_FONT_TYPE_MISMATCH,
    CAIRO_STATUS_USER_FONT_IMMUTABLE,
    CAIRO_STATUS_USER_FONT_ERROR,
    CAIRO_STATUS_NEGATIVE_COUNT,
    CAIRO_STATUS_INVALID_CLUSTERS,
    CAIRO_STATUS_INVALID_SLANT,
    CAIRO_STATUS_INVALID_WEIGHT,
    CAIRO_STATUS_INVALID_SIZE,
    CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED,
    CAIRO_STATUS_DEVICE_TYPE_MISMATCH,
    CAIRO_STATUS_DEVICE_ERROR,
    CAIRO_STATUS_INVALID_MESH_CONSTRUCTION,
    CAIRO_STATUS_DEVICE_FINISHED,

    CAIRO_STATUS_LAST_STATUS
    );

  cairo_operator_t = (
    CAIRO_OPERATOR_CLEAR,
    CAIRO_OPERATOR_SOURCE,
    CAIRO_OPERATOR_OVER,
    CAIRO_OPERATOR_IN,
    CAIRO_OPERATOR_OUT,
    CAIRO_OPERATOR_ATOP,
    CAIRO_OPERATOR_DEST,
    CAIRO_OPERATOR_DEST_OVER,
    CAIRO_OPERATOR_DEST_IN,
    CAIRO_OPERATOR_DEST_OUT,
    CAIRO_OPERATOR_DEST_ATOP,
    CAIRO_OPERATOR_XOR,
    CAIRO_OPERATOR_ADD,
    CAIRO_OPERATOR_SATURATE,
    CAIRO_OPERATOR_MULTIPLY,
    CAIRO_OPERATOR_SCREEN,
    CAIRO_OPERATOR_OVERLAY,
    CAIRO_OPERATOR_DARKEN,
    CAIRO_OPERATOR_LIGHTEN,
    CAIRO_OPERATOR_COLOR_DODGE,
    CAIRO_OPERATOR_COLOR_BURN,
    CAIRO_OPERATOR_HARD_LIGHT,
    CAIRO_OPERATOR_SOFT_LIGHT,
    CAIRO_OPERATOR_DIFFERENCE,
    CAIRO_OPERATOR_EXCLUSION,
    CAIRO_OPERATOR_HSL_HUE,
    CAIRO_OPERATOR_HSL_SATURATION,
    CAIRO_OPERATOR_HSL_COLOR,
    CAIRO_OPERATOR_HSL_LUMINOSITY
    );

  cairo_antialias_t = (
    CAIRO_ANTIALIAS_DEFAULT,
    CAIRO_ANTIALIAS_NONE,
    CAIRO_ANTIALIAS_GRAY,
    CAIRO_ANTIALIAS_SUBPIXEL,
    CAIRO_ANTIALIAS_FAST,
    CAIRO_ANTIALIAS_GOOD,
    CAIRO_ANTIALIAS_BEST
    );

  cairo_fill_rule_t = (
    CAIRO_FILL_RULE_WINDING,
    CAIRO_FILL_RULE_EVEN_ODD
    );

  cairo_line_cap_t = (
    CAIRO_LINE_CAP_BUTT,
    CAIRO_LINE_CAP_ROUND,
    CAIRO_LINE_CAP_SQUARE
    );

  cairo_line_join_t = (
    CAIRO_LINE_JOIN_MITER,
    CAIRO_LINE_JOIN_ROUND,
    CAIRO_LINE_JOIN_BEVEL
    );

  cairo_font_slant_t = (
    CAIRO_FONT_SLANT_NORMAL,
    CAIRO_FONT_SLANT_ITALIC,
    CAIRO_FONT_SLANT_OBLIQUE
    );

  cairo_font_weight_t = (
    CAIRO_FONT_WEIGHT_NORMAL,
    CAIRO_FONT_WEIGHT_BOLD
    );

  cairo_subpixel_order_t = (
    CAIRO_SUBPIXEL_ORDER_DEFAULT,
    CAIRO_SUBPIXEL_ORDER_RGB,
    CAIRO_SUBPIXEL_ORDER_BGR,
    CAIRO_SUBPIXEL_ORDER_VRGB,
    CAIRO_SUBPIXEL_ORDER_VBGR
    );

  cairo_hint_style_t = (
    CAIRO_HINT_STYLE_DEFAULT,
    CAIRO_HINT_STYLE_NONE,
    CAIRO_HINT_STYLE_SLIGHT,
    CAIRO_HINT_STYLE_MEDIUM,
    CAIRO_HINT_STYLE_FULL
    );

  cairo_hint_metrics_t = (
    CAIRO_HINT_METRICS_DEFAULT,
    CAIRO_HINT_METRICS_OFF,
    CAIRO_HINT_METRICS_ON
    );

  cairo_path_data_type_t = (
    CAIRO_PATH_MOVE_TO,
    CAIRO_PATH_LINE_TO,
    CAIRO_PATH_CURVE_TO,
    CAIRO_PATH_CLOSE_PATH
    );

  cairo_content_t       = (
    CAIRO_CONTENT_COLOR = $1000,
    CAIRO_CONTENT_ALPHA       = $2000,
    CAIRO_CONTENT_COLOR_ALPHA = $3000
    );

  cairo_format_t         = (
    CAIRO_FORMAT_INVALID = -1,
    CAIRO_FORMAT_ARGB32 = 0,
    CAIRO_FORMAT_RGB24  = 1,
    CAIRO_FORMAT_A8 = 2,
    CAIRO_FORMAT_A1 = 3,
    CAIRO_FORMAT_RGB16_565 = 4,
    CAIRO_FORMAT_RGB30     = 5
    );

  cairo_extend_t = (
    CAIRO_EXTEND_NONE,
    CAIRO_EXTEND_REPEAT,
    CAIRO_EXTEND_REFLECT,
    CAIRO_EXTEND_PAD
    );

  cairo_filter_t = (
    CAIRO_FILTER_FAST,
    CAIRO_FILTER_GOOD,
    CAIRO_FILTER_BEST,
    CAIRO_FILTER_NEAREST,
    CAIRO_FILTER_BILINEAR,
    CAIRO_FILTER_GAUSSIAN
    );

  cairo_font_type_t = (
    CAIRO_FONT_TYPE_TOY,
    CAIRO_FONT_TYPE_FT,
    CAIRO_FONT_TYPE_WIN32,
    CAIRO_FONT_TYPE_QUARTZ,
    CAIRO_FONT_TYPE_USER
    );

  cairo_pattern_type_t = (
    CAIRO_PATTERN_TYPE_SOLID,
    CAIRO_PATTERN_TYPE_SURFACE,
    CAIRO_PATTERN_TYPE_LINEAR,
    CAIRO_PATTERN_TYPE_RADIAL,
    CAIRO_PATTERN_TYPE_MESH,
    CAIRO_PATTERN_TYPE_RASTER_SOURCE
    );

  cairo_surface_type_t = (
    CAIRO_SURFACE_TYPE_IMAGE,
    CAIRO_SURFACE_TYPE_PDF,
    CAIRO_SURFACE_TYPE_PS,
    CAIRO_SURFACE_TYPE_XLIB,
    CAIRO_SURFACE_TYPE_XCB,
    CAIRO_SURFACE_TYPE_GLITZ,
    CAIRO_SURFACE_TYPE_QUARTZ,
    CAIRO_SURFACE_TYPE_WIN32,
    CAIRO_SURFACE_TYPE_BEOS,
    CAIRO_SURFACE_TYPE_DIRECTFB,
    CAIRO_SURFACE_TYPE_SVG,
    CAIRO_SURFACE_TYPE_OS2,
    CAIRO_SURFACE_TYPE_WIN32_PRINTING,
    CAIRO_SURFACE_TYPE_QUARTZ_IMAGE,
    CAIRO_SURFACE_TYPE_SCRIPT,
    CAIRO_SURFACE_TYPE_QT,
    CAIRO_SURFACE_TYPE_RECORDING,
    CAIRO_SURFACE_TYPE_VG,
    CAIRO_SURFACE_TYPE_GL,
    CAIRO_SURFACE_TYPE_DRM,
    CAIRO_SURFACE_TYPE_TEE,
    CAIRO_SURFACE_TYPE_XML,
    CAIRO_SURFACE_TYPE_SKIA,
    CAIRO_SURFACE_TYPE_SUBSURFACE,
    CAIRO_SURFACE_TYPE_COGL
    );

  cairo_svg_version_t = (
    CAIRO_SVG_VERSION_1_1,
    CAIRO_SVG_VERSION_1_2
    );

  cairo_device_type_t         = (
    CAIRO_DEVICE_TYPE_INVALID = -1,
    CAIRO_DEVICE_TYPE_DRM,
    CAIRO_DEVICE_TYPE_GL,
    CAIRO_DEVICE_TYPE_SCRIPT,
    CAIRO_DEVICE_TYPE_XCB,
    CAIRO_DEVICE_TYPE_XLIB,
    CAIRO_DEVICE_TYPE_XML,
    CAIRO_DEVICE_TYPE_COGL,
    CAIRO_DEVICE_TYPE_WIN32
    );

  cairo_surface_observer_mode_t   = (
    CAIRO_SURFACE_OBSERVER_NORMAL = 0,
    CAIRO_SURFACE_OBSERVER_RECORD_OPERATIONS = $1
    );

  cairo_region_overlap_t = (
    CAIRO_REGION_OVERLAP_IN,     (* completely inside region *)
    CAIRO_REGION_OVERLAP_OUT,    (* completely outside region *)
    CAIRO_REGION_OVERLAP_PART    (* partly inside region *)
    );

  cairo_text_cluster_flags_t         = (
    CAIRO_TEXT_CLUSTER_FLAG_BACKWARD = $00000001
    );

  cairo_pdf_version_t = (
    CAIRO_PDF_VERSION_1_4,
    CAIRO_PDF_VERSION_1_5
    );

  cairo_ps_level_t = (
    CAIRO_PS_LEVEL_2,
    CAIRO_PS_LEVEL_3
    );

  cairo_script_mode_t = (
    CAIRO_SCRIPT_MODE_ASCII,
    CAIRO_SCRIPT_MODE_BINARY
    );

  Pcairo_script_mode_t = ^cairo_script_mode_t;
  Pcairo_script_interpreter_t = ^cairo_script_interpreter_t;
  Pcairo_ps_level_t  = ^cairo_ps_level_t;
  PPcairo_ps_level_t = ^Pcairo_ps_level_t;
  Pcairo_pdf_version_t = ^cairo_pdf_version_t;
  PPcairo_pdf_version_t = ^Pcairo_pdf_version_t;
  Pcairo_region_t    = ^cairo_region_t;
  Pcairo_device_t    = ^cairo_device_t;
  Pcairo_device_type_t = ^cairo_device_type_t;
  Pcairo_region_overlap_t = ^cairo_region_overlap_t;
  Pcairo_surface_observer_mode_t = ^cairo_surface_observer_mode_t;
  Pcairo_svg_version_t = ^cairo_svg_version_t;
  PPcairo_svg_version_t = Pcairo_svg_version_t;
  Pcairo_surface_t      = ^cairo_surface_t;
  PPcairo_surface_t  = ^Pcairo_surface_t;
  Pcairo_t           = ^cairo_t;
  Pcairo_pattern_t   = ^cairo_pattern_t;
  Pcairo_font_options_t = ^cairo_font_options_t;
  Pcairo_font_face_t = ^cairo_font_face_t;
  Pcairo_scaled_font_t = ^cairo_scaled_font_t;
  Pcairo_bool_t      = ^cairo_bool_t;
  cairo_bool_t       = longint;
  Pcairo_matrix_t    = ^cairo_matrix_t;
  Pcairo_user_data_key_t = ^cairo_user_data_key_t;
  Pcairo_glyph_t     = ^cairo_glyph_t;
  PPcairo_glyph_t    = ^Pcairo_glyph_t;
  Pcairo_text_extents_t = ^cairo_text_extents_t;
  Pcairo_font_extents_t = ^cairo_font_extents_t;
  Pcairo_path_data_type_t = ^cairo_path_data_type_t;
  Pcairo_path_data_t = ^cairo_path_data_t;
  Pcairo_path_t      = ^cairo_path_t;
  Pcairo_rectangle_t = ^cairo_rectangle_t;
  Pcairo_rectangle_int_t = ^cairo_rectangle_int_t;
  Pcairo_rectangle_list_t = ^cairo_rectangle_list_t;
  Pcairo_text_cluster_t = ^cairo_text_cluster_t;
  PPcairo_text_cluster_t = ^Pcairo_text_cluster_t;
  Pcairo_text_cluster_flags_t = ^cairo_text_cluster_flags_t;
  Pcairo_script_interpreter_hooks_t = ^cairo_script_interpreter_hooks_t;
  Pcairo_raster_source_acquire_func_t = ^cairo_raster_source_acquire_func_t;
  Pcairo_raster_source_release_func_t = ^cairo_raster_source_release_func_t;

  cairo_destroy_func_t = procedure(Data: Pointer); cdecl;
  cairo_write_func_t   = function(closure: Pointer; Data: PByte; length: longword): cairo_status_t; cdecl;
  cairo_read_func_t = function(closure: Pointer; Data: PByte; length: longword): cairo_status_t; cdecl;
  cairo_user_scaled_font_init_func_t = function(scaled_font: Pcairo_scaled_font_t; cr: Pcairo_t; extents: Pcairo_font_extents_t): cairo_status_t; cdecl;
  cairo_user_scaled_font_render_glyph_func_t = function(scaled_font: Pcairo_scaled_font_t; glyph: longword; cr: Pcairo_t; extents: Pcairo_font_extents_t): cairo_status_t; cdecl;
  cairo_user_scaled_font_text_to_glyphs_func_t = function(scaled_font: Pcairo_scaled_font_t; utf8: PChar; utf8_len: longint; glyphs: PPcairo_glyph_t; num_glyphs: PLongint; clusters: PPcairo_text_cluster_t;
    num_clusters: PLongint; cluster_flags: Pcairo_text_cluster_flags_t): cairo_status_t; cdecl;
  cairo_user_scaled_font_unicode_to_glyph_func_t = function(scaled_font: Pcairo_scaled_font_t; unicode: longword; glyph_index: PLongWord): cairo_status_t; cdecl;
  cairo_surface_observer_callback_t  = procedure(observer, target: Pcairo_surface_t; Data: Pointer); cdecl;
  cairo_raster_source_acquire_func_t = function(pattern: Pcairo_pattern_t; callback_data: Pointer; target: Pcairo_surface_t; const extents: Pcairo_rectangle_int_t): Pcairo_surface_t;
  cairo_raster_source_release_func_t = procedure(pattern: Pcairo_pattern_t; callback_data: Pointer; surface: Pcairo_surface_t); cdecl;
  cairo_raster_source_snapshot_func_t = function(pattern: Pcairo_pattern_t; callback_data: Pointer): cairo_status_t; cdecl;
  cairo_raster_source_copy_func_t     = function(pattern: Pcairo_pattern_t; callback_data: Pointer; const other: Pcairo_pattern_t): cairo_status_t; cdecl;
  cairo_raster_source_finish_func_t = procedure(pattern: Pcairo_pattern_t; callback_data: Pointer); cdecl;
  csi_destroy_func_t        = procedure(closure: Pointer; ptr: Pointer); cdecl;
  csi_surface_create_func_t = function(closure: Pointer; content: cairo_content_t; Width, Height: double; uid: longint): Pcairo_surface_t; cdecl;
  csi_context_create_func_t = function(closure: Pointer; surface: Pcairo_surface_t): Pcairo_t; cdecl;
  csi_show_page_func_t      = procedure(closure: Pointer; cr: Pcairo_t); cdecl;
  csi_copy_page_func_t      = procedure(closure: Pointer; cr: Pcairo_t); cdecl;

  cairo_t           = record          {OPAQUE}
  end;
  cairo_device_t    = record          {OPAQUE}
  end;
  cairo_region_t    = record          {OPAQUE}
  end;
  cairo_surface_t   = record          {OPAQUE}
  end;
  cairo_pattern_t   = record          {OPAQUE}
  end;
  cairo_scaled_font_t = record        {OPAQUE}
  end;
  cairo_font_face_t = record          {OPAQUE}
  end;
  cairo_font_options_t = record       {OPAQUE}
  end;
  cairo_script_interpreter_t = record {OPAQUE}
  end;

  cairo_matrix_t = record
    xx: double;
    yx: double;
    xy: double;
    yy: double;
    x0: double;
    y0: double;
  end;

  cairo_user_data_key_t = record
    unused: longint;
  end;

  cairo_glyph_t = record
    index: longword;
    x: double;
    y: double;
  end;

  cairo_text_extents_t = record
    x_bearing: double;
    y_bearing: double;
    Width: double;
    Height: double;
    x_advance: double;
    y_advance: double;
  end;

  cairo_font_extents_t = record
    ascent: double;
    descent: double;
    Height: double;
    max_x_advance: double;
    max_y_advance: double;
  end;

  cairo_path_data_t = record
    case longint of
      0: (header: record
          _type: cairo_path_data_type_t;
          length: longint;
        end);
      1: (point: record
          x: double;
          y: double;
        end);
  end;

  cairo_path_t = record
    status: cairo_status_t;
    Data: Pcairo_path_data_t;
    num_data: longint;
  end;

  cairo_rectangle_t = record
    x, y, Width, Height: double;
  end;

  cairo_rectangle_int_t = record
    x, y, Width, Height: longint;
  end;

  cairo_rectangle_list_t = record
    status: cairo_status_t;
    rectangles: Pcairo_rectangle_t;
    num_rectangles: longint;
  end;

  cairo_text_cluster_t = record
    num_bytes, num_glyphs: longint;
  end;

  cairo_script_interpreter_hooks_t = record
    closure: Pointer;
    surface_create: csi_surface_create_func_t;
    surface_destroy: csi_destroy_func_t;
    context_create: csi_context_create_func_t;
    context_destroy: csi_destroy_func_t;
    show_page: csi_show_page_func_t;
    copy_page: csi_copy_page_func_t;
  end;

var
  cairo_version: function(): longint; cdecl;
  cairo_version_string: function(): PChar; cdecl;

  (* Functions for manipulating state objects *)
  cairo_create: function(target: Pcairo_surface_t): Pcairo_t; cdecl;
  cairo_reference: function(cr: Pcairo_t): Pcairo_t; cdecl;
  cairo_destroy: procedure(cr: Pcairo_t); cdecl;
  cairo_get_reference_count: function(cr: Pcairo_t): longword; cdecl;
  cairo_get_user_data: function(cr: Pcairo_t; key: Pcairo_user_data_key_t): Pointer; cdecl;
  cairo_set_user_data: function(cr: PCairo_t; key: Pcairo_user_data_key_t; user_data: Pointer; Destroy: cairo_destroy_func_t): cairo_status_t; cdecl;
  cairo_save: procedure(cr: Pcairo_t); cdecl;
  cairo_restore: procedure(cr: Pcairo_t); cdecl;
  cairo_push_group: procedure(cr: PCairo_t); cdecl;
  cairo_push_group_with_content: procedure(cr: PCairo_t; content: cairo_content_t); cdecl;
  cairo_pop_group: function(cr: PCairo_t): Pcairo_pattern_t; cdecl;
  cairo_pop_group_to_source: procedure(cr: PCairo_t); cdecl;

  (* Modify state *)

  cairo_set_operator: procedure(cr: Pcairo_t; op: cairo_operator_t); cdecl;
  cairo_set_source: procedure(cr: Pcairo_t; Source: Pcairo_pattern_t); cdecl;
  cairo_set_source_rgb: procedure(cr: Pcairo_t; red, green, blue: double); cdecl;
  cairo_set_source_rgba: procedure(cr: Pcairo_t; red, green, blue, alpha: double); cdecl;
  cairo_set_source_surface: procedure(cr: Pcairo_t; surface: Pcairo_surface_t; x, y: double); cdecl;
  cairo_set_tolerance: procedure(cr: Pcairo_t; tolerance: double); cdecl;
  cairo_set_antialias: procedure(cr: Pcairo_t; antialias: cairo_antialias_t); cdecl;
  cairo_set_fill_rule: procedure(cr: Pcairo_t; fill_rule: cairo_fill_rule_t); cdecl;
  cairo_set_line_width: procedure(cr: Pcairo_t; Width: double); cdecl;
  cairo_set_line_cap: procedure(cr: Pcairo_t; line_cap: cairo_line_cap_t); cdecl;
  cairo_set_line_join: procedure(cr: Pcairo_t; line_join: cairo_line_join_t); cdecl;
  cairo_set_dash: procedure(cr: Pcairo_t; dashes: PDouble; num_dashes: longint; offset: double); cdecl;
  cairo_set_miter_limit: procedure(cr: Pcairo_t; limit: double); cdecl;
  cairo_translate: procedure(cr: Pcairo_t; tx, ty: double); cdecl;
  cairo_scale: procedure(cr: Pcairo_t; sx, sy: double); cdecl;
  cairo_rotate: procedure(cr: Pcairo_t; angle: double); cdecl;
  cairo_transform: procedure(cr: Pcairo_t; matrix: Pcairo_matrix_t); cdecl;
  cairo_set_matrix: procedure(cr: Pcairo_t; matrix: Pcairo_matrix_t); cdecl;
  cairo_identity_matrix: procedure(cr: Pcairo_t); cdecl;
  cairo_user_to_device: procedure(cr: Pcairo_t; x, y: PDouble); cdecl;
  cairo_user_to_device_distance: procedure(cr: Pcairo_t; dx, dy: PDouble); cdecl;
  cairo_device_to_user: procedure(cr: Pcairo_t; x, y: PDouble); cdecl;
  cairo_device_to_user_distance: procedure(cr: Pcairo_t; dx, dy: PDouble); cdecl;

  (* Path creation functions *)

  cairo_new_path: procedure(cr: Pcairo_t); cdecl;
  cairo_move_to: procedure(cr: Pcairo_t; x, y: double); cdecl;
  cairo_new_sub_path: procedure(cr: Pcairo_t); cdecl;
  cairo_line_to: procedure(cr: Pcairo_t; x, y: double); cdecl;
  cairo_curve_to: procedure(cr: Pcairo_t; x1, y1, x2, y2, x3, y3: double); cdecl;
  cairo_arc: procedure(cr: Pcairo_t; xc, yc, radius, angle1, angle2: double); cdecl;
  cairo_arc_negative: procedure(cr: Pcairo_t; xc, yc, radius, angle1, angle2: double); cdecl;
  cairo_rel_move_to: procedure(cr: Pcairo_t; dx, dy: double); cdecl;
  cairo_rel_line_to: procedure(cr: Pcairo_t; dx, dy: double); cdecl;
  cairo_rel_curve_to: procedure(cr: Pcairo_t; dx1, dy1, dx2, dy2, dx3, dy3: double); cdecl;
  cairo_rectangle: procedure(cr: Pcairo_t; x, y, Width, Height: double); cdecl;
  cairo_close_path: procedure(cr: Pcairo_t); cdecl;
  cairo_path_extents: procedure(cr: Pcairo_t; x1, y1, x2, y2: PDouble); cdecl;

  (* Painting functions *)

  cairo_paint: procedure(cr: Pcairo_t); cdecl;
  cairo_paint_with_alpha: procedure(cr: Pcairo_t; alpha: double); cdecl;
  cairo_mask: procedure(cr: Pcairo_t; pattern: Pcairo_pattern_t); cdecl;
  cairo_mask_surface: procedure(cr: Pcairo_t; surface: Pcairo_surface_t; surface_x, surface_y: double); cdecl;
  cairo_stroke: procedure(cr: Pcairo_t); cdecl;
  cairo_stroke_preserve: procedure(cr: Pcairo_t); cdecl;
  cairo_fill: procedure(cr: Pcairo_t); cdecl;
  cairo_fill_preserve: procedure(cr: Pcairo_t); cdecl;
  cairo_copy_page: procedure(cr: Pcairo_t); cdecl;
  cairo_show_page: procedure(cr: Pcairo_t); cdecl;

  (* Insideness testing *)

  cairo_in_stroke: function(cr: Pcairo_t; x, y: double): cairo_bool_t; cdecl;
  cairo_in_fill: function(cr: Pcairo_t; x, y: double): cairo_bool_t; cdecl;
  cairo_in_clip: function(cr: Pcairo_t; x, y: double): cairo_bool_t; cdecl;

  (* Rectangular extents *)

  cairo_stroke_extents: procedure(cr: Pcairo_t; x1, y1, x2, y2: PDouble); cdecl;
  cairo_fill_extents: procedure(cr: Pcairo_t; x1, y1, x2, y2: PDouble); cdecl;

  (* Clipping *)

  cairo_reset_clip: procedure(cr: Pcairo_t); cdecl;
  cairo_clip: procedure(cr: Pcairo_t); cdecl;
  cairo_clip_preserve: procedure(cr: Pcairo_t); cdecl;
  cairo_clip_extents: procedure(cr: Pcairo_t; x1, y1, x2, y2: PDouble); cdecl;
  cairo_copy_clip_rectangle_list: function(cr: Pcairo_t): Pcairo_rectangle_list_t; cdecl;
  cairo_rectangle_list_destroy: procedure(rectangle_list: Pcairo_rectangle_list_t); cdecl;

  (* Font/Text functions *)

  cairo_glyph_allocate: function(num_glyphs: longint): Pcairo_glyph_t; cdecl;
  cairo_glyph_free: procedure(glyphs: Pcairo_glyph_t); cdecl;
  cairo_text_cluster_allocate: function(num_clusters: longint): Pcairo_text_cluster_t; cdecl;
  cairo_text_cluster_free: procedure(clusters: Pcairo_text_cluster_t); cdecl;
  cairo_font_options_create: function(): Pcairo_font_options_t; cdecl;
  cairo_font_options_copy: function(original: Pcairo_font_options_t): Pcairo_font_options_t; cdecl;
  cairo_font_options_destroy: procedure(options: Pcairo_font_options_t); cdecl;
  cairo_font_options_status: function(options: Pcairo_font_options_t): cairo_status_t; cdecl;
  cairo_font_options_merge: procedure(options, other: Pcairo_font_options_t); cdecl;
  cairo_font_options_equal: function(options, other: Pcairo_font_options_t): cairo_bool_t; cdecl;
  cairo_font_options_hash: function(options: Pcairo_font_options_t): longword; cdecl;
  cairo_font_options_set_antialias: procedure(options: Pcairo_font_options_t; antialias: cairo_antialias_t); cdecl;
  cairo_font_options_get_antialias: function(options: Pcairo_font_options_t): cairo_antialias_t; cdecl;
  cairo_font_options_set_subpixel_order: procedure(options: Pcairo_font_options_t; subpixel_order: cairo_subpixel_order_t); cdecl;
  cairo_font_options_get_subpixel_order: function(options: Pcairo_font_options_t): cairo_subpixel_order_t; cdecl;
  cairo_font_options_set_hint_style: procedure(options: Pcairo_font_options_t; hint_style: cairo_hint_style_t); cdecl;
  cairo_font_options_get_hint_style: function(options: Pcairo_font_options_t): cairo_hint_style_t; cdecl;
  cairo_font_options_set_hint_metrics: procedure(options: Pcairo_font_options_t; hint_metrics: cairo_hint_metrics_t); cdecl;
  cairo_font_options_get_hint_metrics: function(options: Pcairo_font_options_t): cairo_hint_metrics_t; cdecl;

(* This interface is for dealing with text as text, not caring about the
   font object inside the the cairo_t. *)

  cairo_select_font_face: procedure(cr: Pcairo_t; family: PChar; slant: cairo_font_slant_t; weight: cairo_font_weight_t); cdecl;
  cairo_set_font_size: procedure(cr: Pcairo_t; size: double); cdecl;
  cairo_set_font_matrix: procedure(cr: Pcairo_t; matrix: Pcairo_matrix_t); cdecl;
  cairo_get_font_matrix: procedure(cr: Pcairo_t; matrix: Pcairo_matrix_t); cdecl;
  cairo_set_font_options: procedure(cr: Pcairo_t; options: Pcairo_font_options_t); cdecl;
  cairo_get_font_options: procedure(cr: Pcairo_t; options: Pcairo_font_options_t); cdecl;
  cairo_set_font_face: procedure(cr: Pcairo_t; font_face: Pcairo_font_face_t); cdecl;
  cairo_get_font_face: function(cr: Pcairo_t): Pcairo_font_face_t; cdecl;
  cairo_set_scaled_font: procedure(cr: PCairo_t; scaled_font: Pcairo_scaled_font_t); cdecl;
  cairo_get_scaled_font: function(cr: Pcairo_t): Pcairo_scaled_font_t; cdecl;
  cairo_show_text: procedure(cr: Pcairo_t; utf8: PChar); cdecl;
  cairo_show_glyphs: procedure(cr: Pcairo_t; glyphs: Pcairo_glyph_t; num_glyphs: longint); cdecl;
  cairo_text_path: procedure(cr: Pcairo_t; utf8: PChar); cdecl;
  cairo_glyph_path: procedure(cr: Pcairo_t; glyphs: Pcairo_glyph_t; num_glyphs: longint); cdecl;
  cairo_text_extents: procedure(cr: Pcairo_t; utf8: PChar; extents: Pcairo_text_extents_t); cdecl;
  cairo_glyph_extents: procedure(cr: Pcairo_t; glyphs: Pcairo_glyph_t; num_glyphs: longint; extents: Pcairo_text_extents_t); cdecl;
  cairo_font_extents: procedure(cr: Pcairo_t; extents: Pcairo_font_extents_t); cdecl;

  (* Generic identifier for a font style *)

  cairo_font_face_reference: function(font_face: Pcairo_font_face_t): Pcairo_font_face_t; cdecl;
  cairo_font_face_destroy: procedure(font_face: Pcairo_font_face_t); cdecl;
  cairo_font_face_get_reference_count: function(font_face: Pcairo_font_face_t): longword; cdecl;
  cairo_font_face_status: function(font_face: Pcairo_font_face_t): cairo_status_t; cdecl;
  cairo_font_face_get_type: function(font_face: Pcairo_font_face_t): cairo_font_type_t; cdecl;
  cairo_font_face_get_user_data: function(font_face: Pcairo_font_face_t; key: Pcairo_user_data_key_t): Pointer; cdecl;
  cairo_font_face_set_user_data: function(font_face: Pcairo_font_face_t; key: Pcairo_user_data_key_t; user_data: Pointer; Destroy: cairo_destroy_func_t): cairo_status_t; cdecl;

  (* Portable interface to general font features *)

  cairo_scaled_font_create: function(font_face: Pcairo_font_face_t; font_matrix: Pcairo_matrix_t; ctm: Pcairo_matrix_t; options: Pcairo_font_options_t): Pcairo_scaled_font_t; cdecl;
  cairo_scaled_font_reference: function(scaled_font: Pcairo_scaled_font_t): Pcairo_scaled_font_t; cdecl;
  cairo_scaled_font_destroy: procedure(scaled_font: Pcairo_scaled_font_t); cdecl;
  cairo_scaled_font_get_reference_count: function(scaled_font: Pcairo_scaled_font_t): longword; cdecl;
  cairo_scaled_font_status: function(scaled_font: Pcairo_scaled_font_t): cairo_status_t; cdecl;
  cairo_scaled_font_get_type: function(scaled_font: Pcairo_scaled_font_t): cairo_font_type_t; cdecl;
  cairo_scaled_font_get_user_data: function(scaled_font: Pcairo_scaled_font_t; key: Pcairo_user_data_key_t): Pointer; cdecl;
  cairo_scaled_font_set_user_data: function(scaled_font: Pcairo_scaled_font_t; key: Pcairo_user_data_key_t; user_data: Pointer; Destroy: cairo_destroy_func_t): cairo_status_t; cdecl;
  cairo_scaled_font_extents: procedure(scaled_font: Pcairo_scaled_font_t; extents: Pcairo_font_extents_t); cdecl;
  cairo_scaled_font_text_extents: procedure(scaled_font: Pcairo_scaled_font_t; utf8: PChar; extents: Pcairo_text_extents_t); cdecl;
  cairo_scaled_font_glyph_extents: procedure(scaled_font: Pcairo_scaled_font_t; glyphs: Pcairo_glyph_t; num_glyphs: longint; extents: Pcairo_text_extents_t); cdecl;
  cairo_scaled_font_text_to_glyphs: function(scaled_font: Pcairo_scaled_font_t; x, y: double; const utf8: PChar; utf8_len: longint; glyphs: PPcairo_glyph_t; num_glyphs: PLongInt; clusters: PPcairo_text_cluster_t;
  num_clusters: PLongInt; cluster_flags: Pcairo_text_cluster_flags_t): cairo_status_t; cdecl;
  cairo_scaled_font_get_font_face: function(scaled_font: Pcairo_scaled_font_t): Pcairo_font_face_t; cdecl;
  cairo_scaled_font_get_font_matrix: procedure(scaled_font: Pcairo_scaled_font_t; font_matrix: Pcairo_matrix_t); cdecl;
  cairo_scaled_font_get_ctm: procedure(scaled_font: Pcairo_scaled_font_t; ctm: Pcairo_matrix_t); cdecl;
  cairo_scaled_font_get_scale_matrix: procedure(scaled_font: Pcairo_scaled_font_t; scale_matrix: Pcairo_matrix_t); cdecl;
  cairo_scaled_font_get_font_options: procedure(scaled_font: Pcairo_scaled_font_t; options: Pcairo_font_options_t); cdecl;

  (* Toy fonts *)

  cairo_toy_font_face_create: function(const family: PChar; slant: cairo_font_slant_t; weight: cairo_font_weight_t): Pcairo_font_face_t; cdecl;
  cairo_toy_font_face_get_family: function(font_face: Pcairo_font_face_t): PChar; cdecl;
  cairo_toy_font_face_get_slant: function(font_face: Pcairo_font_face_t): cairo_font_slant_t; cdecl;
  cairo_toy_font_face_get_weight: function(font_face: Pcairo_font_face_t): cairo_font_weight_t; cdecl;

  (* User fonts *)

  cairo_user_font_face_create: function(): Pcairo_font_face_t; cdecl;

  (* User-font method setters *)

  cairo_user_font_face_set_init_func: procedure(font_face: Pcairo_font_face_t; init_func: cairo_user_scaled_font_init_func_t); cdecl;
  cairo_user_font_face_set_render_glyph_func: procedure(font_face: Pcairo_font_face_t; render_glyph_func: cairo_user_scaled_font_render_glyph_func_t); cdecl;
  cairo_user_font_face_set_text_to_glyphs_func: procedure(font_face: Pcairo_font_face_t; text_to_glyphs_func: cairo_user_scaled_font_text_to_glyphs_func_t); cdecl;
  cairo_user_font_face_set_unicode_to_glyph_func: procedure(font_face: Pcairo_font_face_t; unicode_to_glyph_func: cairo_user_scaled_font_unicode_to_glyph_func_t); cdecl;

  (* User-font method getters *)

  cairo_user_font_face_get_init_func: function(font_face: Pcairo_font_face_t): cairo_user_scaled_font_init_func_t; cdecl;
  cairo_user_font_face_get_render_glyph_func: function(font_face: Pcairo_font_face_t): cairo_user_scaled_font_render_glyph_func_t; cdecl;
  cairo_user_font_face_get_text_to_glyphs_func: function(font_face: Pcairo_font_face_t): cairo_user_scaled_font_text_to_glyphs_func_t; cdecl;
  cairo_user_font_face_get_unicode_to_glyph_func: function(font_face: Pcairo_font_face_t): cairo_user_scaled_font_unicode_to_glyph_func_t; cdecl;

  (* Query functions *)

  cairo_get_operator: function(cr: Pcairo_t): cairo_operator_t; cdecl;
  cairo_get_source: function(cr: Pcairo_t): Pcairo_pattern_t; cdecl;
  cairo_get_tolerance: function(cr: Pcairo_t): double; cdecl;
  cairo_get_antialias: function(cr: Pcairo_t): cairo_antialias_t; cdecl;
  cairo_get_current_point: procedure(cr: Pcairo_t; x, y: PDouble); cdecl;
  cairo_get_fill_rule: function(cr: Pcairo_t): cairo_fill_rule_t; cdecl;
  cairo_get_line_width: function(cr: Pcairo_t): double; cdecl;
  cairo_get_line_cap: function(cr: Pcairo_t): cairo_line_cap_t; cdecl;
  cairo_get_line_join: function(cr: Pcairo_t): cairo_line_join_t; cdecl;
  cairo_get_miter_limit: function(cr: Pcairo_t): double; cdecl;
  cairo_get_dash_count: function(cr: Pcairo_t): longint; cdecl;
  cairo_get_dash: procedure(cr: Pcairo_t; dashes, offset: PDouble); cdecl;
  cairo_get_matrix: procedure(cr: Pcairo_t; matrix: Pcairo_matrix_t); cdecl;
  cairo_get_target: function(cr: Pcairo_t): Pcairo_surface_t; cdecl;
  cairo_get_group_target: function(cr: Pcairo_t): Pcairo_surface_t; cdecl;

  cairo_copy_path: function(cr: Pcairo_t): Pcairo_path_t; cdecl;
  cairo_copy_path_flat: function(cr: Pcairo_t): Pcairo_path_t; cdecl;
  cairo_append_path: procedure(cr: Pcairo_t; path: Pcairo_path_t); cdecl;
  cairo_path_destroy: procedure(path: Pcairo_path_t); cdecl;

  (* Error status queries *)

  cairo_status: function(cr: Pcairo_t): cairo_status_t; cdecl;
  cairo_status_to_string: function(status: cairo_status_t): PChar; cdecl;

  (* Surface manipulation *)

  cairo_surface_create_similar: function(other: Pcairo_surface_t; content: cairo_content_t; Width, Height: longint): Pcairo_surface_t; cdecl;
  cairo_surface_create_similar_image: function(other: Pcairo_surface_t; format: cairo_format_t; Width, Height: longint): Pcairo_surface_t; cdecl;
  cairo_surface_map_to_image: function(surface: Pcairo_surface_t; const extents: Pcairo_rectangle_int_t): Pcairo_surface_t; cdecl;
  cairo_surface_unmap_image: procedure(surface: Pcairo_surface_t; image: Pcairo_surface_t); cdecl;
  cairo_surface_create_for_rectangle: function(target: Pcairo_surface_t; x, y, Width, Height: double): Pcairo_surface_t; cdecl;
  cairo_surface_create_observer: function(target: Pcairo_surface_t; mode: cairo_surface_observer_mode_t): Pcairo_surface_t; cdecl;
  cairo_surface_observer_add_paint_callback: function(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; Data: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_add_mask_callback: function(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; Data: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_add_fill_callback: function(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; Data: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_add_stroke_callback: function(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; Data: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_add_glyphs_callback: function(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; Data: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_add_flush_callback: function(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; Data: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_add_finish_callback: function(abstract_surface: Pcairo_surface_t; func: cairo_surface_observer_callback_t; Data: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_print: function(surface: Pcairo_surface_t; write_func: cairo_write_func_t; closure: Pointer): cairo_status_t; cdecl;
  cairo_surface_observer_elapsed: function(surface: Pcairo_surface_t): double; cdecl;
  cairo_device_observer_print: function(device: Pcairo_device_t; write_func: cairo_write_func_t; closure: Pointer): cairo_status_t; cdecl;
  cairo_device_observer_elapsed: function(device: Pcairo_device_t): double; cdecl;
  cairo_device_observer_paint_elapsed: function(device: Pcairo_device_t): double; cdecl;
  cairo_device_observer_mask_elapsed: function(device: Pcairo_device_t): double; cdecl;
  cairo_device_observer_fill_elapsed: function(device: Pcairo_device_t): double; cdecl;
  cairo_device_observer_stroke_elapsed: function(device: Pcairo_device_t): double; cdecl;
  cairo_device_observer_glyphs_elapsed: function(device: Pcairo_device_t): double; cdecl;
  cairo_surface_reference: function(surface: Pcairo_surface_t): Pcairo_surface_t; cdecl;
  cairo_surface_finish: procedure(surface: Pcairo_surface_t); cdecl;
  cairo_surface_destroy: procedure(surface: Pcairo_surface_t); cdecl;
  cairo_surface_get_device: function(surface: Pcairo_surface_t): Pcairo_device_t; cdecl;
  cairo_surface_get_reference_count: function(surface: Pcairo_surface_t): longword; cdecl;
  cairo_surface_status: function(surface: Pcairo_surface_t): cairo_status_t; cdecl;
  cairo_surface_get_type: function(surface: Pcairo_surface_t): cairo_surface_type_t; cdecl;
  cairo_surface_get_content: function(surface: Pcairo_surface_t): cairo_content_t; cdecl;
  cairo_surface_write_to_png: function(surface: Pcairo_surface_t; filename: PChar): cairo_status_t; cdecl;
  cairo_surface_write_to_png_stream: function(surface: Pcairo_surface_t; write_func: cairo_write_func_t; closure: Pointer): cairo_status_t; cdecl;
  cairo_surface_get_user_data: function(surface: Pcairo_surface_t; key: Pcairo_user_data_key_t): Pointer; cdecl;
  cairo_surface_set_user_data: function(surface: Pcairo_surface_t; key: Pcairo_user_data_key_t; user_data: Pointer; Destroy: cairo_destroy_func_t): cairo_status_t; cdecl;
  cairo_surface_get_mime_data: procedure(surface: Pcairo_surface_t; const mime_type: PChar; const Data: PPChar; length: longword); cdecl;
  cairo_surface_set_mime_data: function(surface: Pcairo_surface_t; const mime_type: PChar; const Data: PChar; length: longword; Destroy: cairo_destroy_func_t; closure: Pointer): cairo_status_t; cdecl;
  cairo_surface_supports_mime_type: function(surface: Pcairo_surface_t; const mime_type: PChar): cairo_bool_t; cdecl;
  cairo_surface_get_font_options: procedure(surface: Pcairo_surface_t; options: Pcairo_font_options_t); cdecl;
  cairo_surface_flush: procedure(surface: Pcairo_surface_t); cdecl;
  cairo_surface_mark_dirty: procedure(surface: Pcairo_surface_t); cdecl;
  cairo_surface_mark_dirty_rectangle: procedure(surface: Pcairo_surface_t; x, y, Width, Height: longint); cdecl;
  cairo_surface_set_device_offset: procedure(surface: Pcairo_surface_t; x_offset, y_offset: double); cdecl;
  cairo_surface_get_device_offset: procedure(surface: Pcairo_surface_t; x_offset, y_offset: PDouble); cdecl;
  cairo_surface_set_fallback_resolution: procedure(surface: Pcairo_surface_t; x_pixels_per_inch, y_pixels_per_inch: double); cdecl;
  cairo_surface_get_fallback_resolution: procedure(surface: Pcairo_surface_t; x_pixels_per_inch, y_pixels_per_inch: double); cdecl;
  cairo_surface_copy_page: procedure(surface: Pcairo_surface_t); cdecl;
  cairo_surface_show_page: procedure(surface: Pcairo_surface_t); cdecl;
  cairo_surface_has_show_text_glyphs: function(surface: Pcairo_surface_t): cairo_bool_t; cdecl;

  (* Image-surface s *)

  cairo_image_surface_create: function(format: cairo_format_t; Width, Height: longint): Pcairo_surface_t; cdecl;
  cairo_format_stride_for_width: function(format: cairo_format_t; Width: longint): longint; cdecl;
  cairo_image_surface_create_for_data: function(Data: Pbyte; format: cairo_format_t; Width, Height, stride: longint): Pcairo_surface_t; cdecl;
  cairo_image_surface_get_data: function(surface: Pcairo_surface_t): PChar; cdecl;
  cairo_image_surface_get_format: function(surface: Pcairo_surface_t): cairo_format_t; cdecl;
  cairo_image_surface_get_width: function(surface: Pcairo_surface_t): longint; cdecl;
  cairo_image_surface_get_height: function(surface: Pcairo_surface_t): longint; cdecl;
  cairo_image_surface_get_stride: function(surface: Pcairo_surface_t): longint; cdecl;
  cairo_image_surface_create_from_png: function(filename: PChar): Pcairo_surface_t; cdecl;
  cairo_image_surface_create_from_png_stream: function(read_func: cairo_read_func_t; closure: Pointer): Pcairo_surface_t; cdecl;

  (* Recording-surface s *)

  cairo_recording_surface_create: function(content: cairo_content_t; const extents: Pcairo_rectangle_t): Pcairo_surface_t; cdecl;
  cairo_recording_surface_ink_extents: procedure(surface: Pcairo_surface_t; x0, y0, Width, Height: PDouble); cdecl;
  cairo_recording_surface_get_extents: function(surface: Pcairo_surface_t; const extents: Pcairo_rectangle_t): cairo_bool_t; cdecl;

  (* raster-source pattern (callback) s *)

  cairo_pattern_create_raster_source: function(user_data: Pointer; content: cairo_content_t; Width, Height: longint): Pcairo_pattern_t; cdecl;
  cairo_raster_source_pattern_set_callback_data: procedure(pattern: Pcairo_pattern_t; Data: Pointer); cdecl;
  cairo_raster_source_pattern_get_callback_data: function(pattern: Pcairo_pattern_t): Pointer; cdecl;
  cairo_raster_source_pattern_set_acquire: procedure(pattern: Pcairo_pattern_t; acquire: cairo_raster_source_acquire_func_t; Release: cairo_raster_source_release_func_t); cdecl;
  cairo_raster_source_pattern_get_acquire: procedure(pattern: Pcairo_pattern_t; acquire: Pcairo_raster_source_acquire_func_t; Release: Pcairo_raster_source_release_func_t); cdecl;
  cairo_raster_source_pattern_set_snapshot: procedure(pattern: Pcairo_pattern_t; snapshot: cairo_raster_source_snapshot_func_t); cdecl;
  cairo_raster_source_pattern_get_snapshot: function(pattern: Pcairo_pattern_t): cairo_raster_source_snapshot_func_t; cdecl;
  cairo_raster_source_pattern_set_copy: procedure(pattern: Pcairo_pattern_t; copy: cairo_raster_source_copy_func_t); cdecl;
  cairo_raster_source_pattern_get_copy: function(pattern: Pcairo_pattern_t): cairo_raster_source_copy_func_t; cdecl;
  cairo_raster_source_pattern_set_finish: procedure(pattern: Pcairo_pattern_t; finish: cairo_raster_source_finish_func_t); cdecl;
  cairo_raster_source_pattern_get_finish: function(pattern: Pcairo_pattern_t): cairo_raster_source_finish_func_t; cdecl;

  (* Pattern creation s *)

  cairo_pattern_create_rgb: function(red, green, blue: double): Pcairo_pattern_t; cdecl;
  cairo_pattern_create_rgba: function(red, green, blue, alpha: double): Pcairo_pattern_t; cdecl;
  cairo_pattern_create_for_surface: function(surface: Pcairo_surface_t): Pcairo_pattern_t; cdecl;
  cairo_pattern_create_linear: function(x0, y0, x1, y1: double): Pcairo_pattern_t; cdecl;
  cairo_pattern_create_radial: function(cx0, cy0, radius0, cx1, cy1, radius1: double): Pcairo_pattern_t; cdecl;
  cairo_pattern_create_mesh: function(): Pcairo_pattern_t; cdecl;
  cairo_pattern_reference: function(pattern: Pcairo_pattern_t): Pcairo_pattern_t; cdecl;
  cairo_pattern_destroy: procedure(pattern: Pcairo_pattern_t); cdecl;
  cairo_pattern_get_reference_count: function(pattern: Pcairo_pattern_t): longword; cdecl;
  cairo_pattern_status: function(pattern: Pcairo_pattern_t): cairo_status_t; cdecl;
  cairo_pattern_get_user_data: function(pattern: Pcairo_pattern_t; key: Pcairo_user_data_key_t): Pointer; cdecl;
  cairo_pattern_set_user_data: function(pattern: Pcairo_pattern_t; key: Pcairo_user_data_key_t; user_data: Pointer; Destroy: cairo_destroy_func_t): cairo_status_t; cdecl;
  cairo_pattern_get_type: function(pattern: Pcairo_pattern_t): cairo_pattern_type_t; cdecl;
  cairo_pattern_add_color_stop_rgb: procedure(pattern: Pcairo_pattern_t; offset, red, green, blue: double); cdecl;
  cairo_pattern_add_color_stop_rgba: procedure(pattern: Pcairo_pattern_t; offset, red, green, blue, alpha: double); cdecl;
  cairo_mesh_pattern_begin_patch: procedure(pattern: Pcairo_pattern_t); cdecl;
  cairo_mesh_pattern_end_patch: procedure(pattern: Pcairo_pattern_t); cdecl;
  cairo_mesh_pattern_curve_to: procedure(pattern: Pcairo_pattern_t; x1, y1, x2, y2, x3, y3: double); cdecl;
  cairo_mesh_pattern_line_to: procedure(pattern: Pcairo_pattern_t; x, y: double); cdecl;
  cairo_mesh_pattern_move_to: procedure(pattern: Pcairo_pattern_t; x, y: double); cdecl;
  cairo_mesh_pattern_set_control_point: procedure(pattern: Pcairo_pattern_t; point_num: longword; x, y: double); cdecl;
  cairo_mesh_pattern_set_corner_color_rgb: procedure(pattern: Pcairo_pattern_t; corner_num: longword; red, green, blue: double); cdecl;
  cairo_mesh_pattern_set_corner_color_rgba: procedure(pattern: Pcairo_pattern_t; corner_num: longword; red, green, blue, alpha: double); cdecl;
  cairo_pattern_set_matrix: procedure(pattern: Pcairo_pattern_t; matrix: Pcairo_matrix_t); cdecl;
  cairo_pattern_get_matrix: procedure(pattern: Pcairo_pattern_t; matrix: Pcairo_matrix_t); cdecl;
  cairo_pattern_set_extend: procedure(pattern: Pcairo_pattern_t; extend: cairo_extend_t); cdecl;
  cairo_pattern_get_extend: function(pattern: Pcairo_pattern_t): cairo_extend_t; cdecl;
  cairo_pattern_set_filter: procedure(pattern: Pcairo_pattern_t; filter: cairo_filter_t); cdecl;
  cairo_pattern_get_filter: function(pattern: Pcairo_pattern_t): cairo_filter_t; cdecl;
  cairo_pattern_get_rgba: function(pattern: Pcairo_pattern_t; red, green, blue, alpha: PDouble): cairo_status_t; cdecl;
  cairo_pattern_get_surface: function(pattern: Pcairo_pattern_t; surface: PPcairo_surface_t): cairo_status_t; cdecl;
  cairo_pattern_get_color_stop_rgba: function(pattern: Pcairo_pattern_t; index: longint; offset, red, green, blue, alpha: PDouble): cairo_status_t; cdecl;
  cairo_pattern_get_color_stop_count: function(pattern: Pcairo_pattern_t; Count: PLongInt): cairo_status_t; cdecl;
  cairo_pattern_get_linear_points: function(pattern: Pcairo_pattern_t; x0, y0, x1, y1: PDouble): cairo_status_t; cdecl;
  cairo_pattern_get_radial_circles: function(pattern: Pcairo_pattern_t; x0, y0, r0, x1, y1, r1: PDouble): cairo_status_t; cdecl;
  cairo_mesh_pattern_get_patch_count: function(pattern: Pcairo_pattern_t; Count: PLongWord): cairo_status_t; cdecl;
  cairo_mesh_pattern_get_path: function(pattern: Pcairo_pattern_t; patch_num: longword): Pcairo_path_t; cdecl;
  cairo_mesh_pattern_get_corner_color_rgba: function(pattern: Pcairo_pattern_t; patch_num: longword; corner_num: longword; red, green, blue, alpha: PDouble): cairo_status_t; cdecl;
  cairo_mesh_pattern_get_control_point: function(pattern: Pcairo_pattern_t; patch_num: longword; point_num: longword; x, y: PDouble): cairo_status_t; cdecl;

  (* Matrix s *)

  cairo_matrix_init: procedure(matrix: Pcairo_matrix_t; xx, yx, xy, yy, x0, y0: double); cdecl;
  cairo_matrix_init_identity: procedure(matrix: Pcairo_matrix_t); cdecl;
  cairo_matrix_init_translate: procedure(matrix: Pcairo_matrix_t; tx, ty: double); cdecl;
  cairo_matrix_init_scale: procedure(matrix: Pcairo_matrix_t; sx, sy: double); cdecl;
  cairo_matrix_init_rotate: procedure(matrix: Pcairo_matrix_t; radians: double); cdecl;
  cairo_matrix_translate: procedure(matrix: Pcairo_matrix_t; tx, ty: double); cdecl;
  cairo_matrix_scale: procedure(matrix: Pcairo_matrix_t; sx, sy: double); cdecl;
  cairo_matrix_rotate: procedure(matrix: Pcairo_matrix_t; radians: double); cdecl;
  cairo_matrix_invert: function(matrix: Pcairo_matrix_t): cairo_status_t; cdecl;
  cairo_matrix_multiply: procedure(Result, a, b: Pcairo_matrix_t); cdecl;
  cairo_matrix_transform_distance: procedure(matrix: Pcairo_matrix_t; dx, dy: PDouble); cdecl;
  cairo_matrix_transform_point: procedure(matrix: Pcairo_matrix_t; x, y: PDouble); cdecl;

  (* Region s *)

  cairo_region_create: function(): Pcairo_region_t; cdecl;
  cairo_region_create_rectangle: function(const rectangle: Pcairo_rectangle_int_t): Pcairo_region_t; cdecl;
  cairo_region_create_rectangles: function(const rects: Pcairo_rectangle_int_t; Count: longint): Pcairo_region_t; cdecl;
  cairo_region_copy: function(const original: Pcairo_region_t): Pcairo_region_t; cdecl;
  cairo_region_reference: function(region: Pcairo_region_t): Pcairo_region_t; cdecl;
  cairo_region_destroy: procedure(region: Pcairo_region_t); cdecl;
  cairo_region_equal: function(const a: Pcairo_region_t; const b: Pcairo_region_t): cairo_bool_t; cdecl;
  cairo_region_status: function(const region: Pcairo_region_t): cairo_status_t; cdecl;
  cairo_region_get_extents: procedure(const region: Pcairo_region_t; extents: Pcairo_rectangle_int_t); cdecl;
  cairo_region_num_rectangles: function(const region: Pcairo_region_t): longint; cdecl;
  cairo_region_get_rectangle: procedure(const region: Pcairo_region_t; nth: longint; rectangle: Pcairo_rectangle_int_t); cdecl;
  cairo_region_is_empty: function(const region: Pcairo_region_t): cairo_bool_t; cdecl;
  cairo_region_contains_rectangle: function(const region: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_region_overlap_t; cdecl;
  cairo_region_contains_point: function(const region: Pcairo_region_t; x, y: longint): cairo_bool_t; cdecl;
  cairo_region_translate: procedure(const region: Pcairo_region_t; dx, dy: longint); cdecl;
  cairo_region_subtract: function(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl;
  cairo_region_subtract_rectangle: function(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl;
  cairo_region_intersect: function(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl;
  cairo_region_intersect_rectangle: function(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl;
  cairo_region_union: function(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl;
  cairo_region_union_rectangle: function(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl;
  cairo_region_xor: function(dst: Pcairo_region_t; const other: Pcairo_region_t): cairo_status_t; cdecl;
  cairo_region_xor_rectangle: function(dst: Pcairo_region_t; const rectangle: Pcairo_rectangle_int_t): cairo_status_t; cdecl;

  (* PDF s *)

  cairo_pdf_surface_create: function(filename: PChar; width_in_points, height_in_points: double): Pcairo_surface_t; cdecl;
  cairo_pdf_surface_create_for_stream: function(write_func: cairo_write_func_t; closure: Pointer; width_in_points, height_in_points: double): Pcairo_surface_t; cdecl;
  cairo_pdf_surface_restrict_to_version: procedure(surface: Pcairo_surface_t; version: cairo_pdf_version_t); cdecl;
  cairo_pdf_get_versions: procedure(const versions: PPcairo_pdf_version_t; num_versions: PLongInt); cdecl;
  cairo_pdf_version_to_string: function(version: cairo_pdf_version_t): PChar; cdecl;
  cairo_pdf_surface_set_size: procedure(surface: Pcairo_surface_t; width_in_points, height_in_points: double); cdecl;

  (* PS s *)

  cairo_ps_surface_create: function(filename: PChar; width_in_points, height_in_points: double): Pcairo_surface_t; cdecl;
  cairo_ps_surface_create_for_stream: function(write_func: cairo_write_func_t; closure: Pointer; width_in_points, height_in_points: double): Pcairo_surface_t; cdecl;
  cairo_ps_surface_restrict_to_level: procedure(surface: Pcairo_surface_t; level: cairo_ps_level_t); cdecl;
  cairo_ps_get_levels: procedure(const levels: PPcairo_ps_level_t; num_levels: PLongInt); cdecl;
  cairo_ps_level_to_string: function(level: cairo_ps_level_t): PChar; cdecl;
  cairo_ps_surface_set_eps: procedure(surface: Pcairo_surface_t; eps: cairo_bool_t); cdecl;
  cairo_ps_surface_get_eps: function(surface: Pcairo_surface_t): cairo_bool_t; cdecl;
  cairo_ps_surface_set_size: procedure(surface: Pcairo_surface_t; width_in_points, height_in_points: double); cdecl;
  cairo_ps_surface_dsc_comment: procedure(surface: Pcairo_surface_t; comment: PChar); cdecl;
  cairo_ps_surface_dsc_begin_setup: procedure(surface: Pcairo_surface_t); cdecl;
  cairo_ps_surface_dsc_begin_page_setup: procedure(surface: Pcairo_surface_t); cdecl;

  (* SVG s *)

  cairo_svg_surface_create: function(filename: PChar; width_in_points, height_in_points: double): Pcairo_surface_t; cdecl;
  cairo_svg_surface_create_for_stream: function(write_func: cairo_write_func_t; closure: Pointer; width_in_points, height_in_points: double): Pcairo_surface_t; cdecl;
  cairo_svg_surface_restrict_to_version: procedure(surface: Pcairo_surface_t; version: cairo_svg_version_t); cdecl;
  cairo_svg_get_versions: procedure(versions: ppcairo_svg_version_t; num_versions: pcint); cdecl;
  cairo_svg_version_to_string: function(version: cairo_svg_version_t): PChar; cdecl;

  (* TEE s *)

  cairo_tee_surface_create: function(master: Pcairo_surface_t): Pcairo_surface_t; cdecl;
  cairo_tee_surface_add: procedure(surface: Pcairo_surface_t; target: Pcairo_surface_t); cdecl;
  cairo_tee_surface_remove: procedure(surface: Pcairo_surface_t; target: Pcairo_surface_t); cdecl;
  cairo_tee_surface_index: function(surface: Pcairo_surface_t; index: longword): Pcairo_surface_t; cdecl;

  (* Backend device manipulation *)

  cairo_device_reference: function(device: Pcairo_device_t): pcairo_device_t; cdecl;
  cairo_device_get_type: function(device: Pcairo_device_t): cairo_device_type_t; cdecl;
  cairo_device_status: function(device: Pcairo_device_t): cairo_status_t; cdecl;
  cairo_device_acquire: function(device: Pcairo_device_t): cairo_status_t; cdecl;
  cairo_device_release: procedure(device: Pcairo_device_t); cdecl;
  cairo_device_flush: procedure(device: Pcairo_device_t); cdecl;
  cairo_device_finish: procedure(device: Pcairo_device_t); cdecl;
  cairo_device_destroy: procedure(device: Pcairo_device_t); cdecl;
  cairo_device_get_reference_count: function(device: Pcairo_device_t): longword; cdecl;
  cairo_device_get_user_data: function(device: Pcairo_device_t; const key: pcairo_user_data_key_t): Pointer; cdecl;
  cairo_device_set_user_data: function(device: Pcairo_device_t; const key: pcairo_user_data_key_t; user_data: Pointer; Destroy: cairo_destroy_func_t): cairo_status_t; cdecl;

  (* Script s *)

  cairo_script_create: function(const filename: PChar): Pcairo_device_t; cdecl;
  cairo_script_create_for_stream: function(write_func: cairo_write_func_t; closure: Pointer): Pcairo_device_t; cdecl;
  cairo_script_write_comment: procedure(script: Pcairo_device_t; const comment: PChar; len: longint); cdecl;
  cairo_script_set_mode: procedure(script: Pcairo_device_t; mode: cairo_script_mode_t); cdecl;
  cairo_script_get_mode: function(script: Pcairo_device_t): cairo_script_mode_t; cdecl;
  cairo_script_surface_create: function(script: Pcairo_device_t; content: cairo_content_t; Width, Height: double): Pcairo_surface_t; cdecl;
  cairo_script_surface_create_for_target: function(script: Pcairo_device_t; target: Pcairo_surface_t): Pcairo_surface_t; cdecl;
  cairo_script_from_recording_surface: function(script: Pcairo_device_t; recording_surface: Pcairo_surface_t): cairo_status_t; cdecl;

  (* XXX expose csi_dictionary_t and pass to hooks *)

  cairo_script_interpreter_create: function(): Pcairo_script_interpreter_t; cdecl;
  cairo_script_interpreter_install_hooks: procedure(ctx: Pcairo_script_interpreter_t; const hooks: Pcairo_script_interpreter_hooks_t); cdecl;
  cairo_script_interpreter_run: function(ctx: Pcairo_script_interpreter_t; filename: PChar): cairo_status_t; cdecl;
  cairo_script_interpreter_feed_stream: function(ctx: Pcairo_script_interpreter_t; var stream: file): cairo_status_t; cdecl;
  cairo_script_interpreter_feed_string: function(ctx: Pcairo_script_interpreter_t; const line: PChar; len: longint): cairo_status_t; cdecl;
  cairo_script_interpreter_get_line_number: function(ctx: Pcairo_script_interpreter_t): longword; cdecl;
  cairo_script_interpreter_reference: function(ctx: Pcairo_script_interpreter_t): Pcairo_script_interpreter_t; cdecl;
  cairo_script_interpreter_finish: function(ctx: Pcairo_script_interpreter_t): cairo_status_t; cdecl;
  cairo_script_interpreter_destroy: function(ctx: Pcairo_script_interpreter_t): cairo_status_t; cdecl;
  cairo_script_interpreter_translate_stream: function(var stream: file; write_func: cairo_write_func_t; closure: Pointer): cairo_status_t; cdecl;

  (* s to be used while debugging (not intended for use in production code) *)
  cairo_debug_reset_static_data: procedure(); cdecl;

  {Special function for dynamic loading of lib ...}

  ca_Handle: TLibHandle = dynlibs.NilHandle; // this will hold our handle for the lib;

  ReferenceCounter: cardinal = 0;  // Reference counter

function ca_IsLoaded: Boolean; inline;
function ca_Load(const libfilename: string): Boolean; // load the lib
procedure ca_Unload(); // unload and frees the lib from memory : do not forget to call it before close application.

  //Helper function to retrieve decoded version
procedure cairo_version_decode(out major, minor, micro: longint);

implementation

function ca_IsLoaded: Boolean;
begin
  Result := (ca_Handle <> dynlibs.NilHandle);
end;

function ca_Load(const libfilename: string): Boolean;
var
  thelib: string;
begin
  Result := False;
  if ca_Handle <> 0 then
  begin
    Inc(ReferenceCounter);
    Result := True; {is it already there ?}
  end
  else
  begin {go & load the library}
    if Length(libfilename) = 0 then
      thelib := LIB_CAIRO
    else
      thelib := libfilename;
    ca_Handle := DynLibs.SafeLoadLibrary(thelib);      // obtain the handle we want
    if ca_Handle <> DynLibs.NilHandle then
    begin
      {now we tie the functions to the VARs from above}
      Pointer(cairo_version)       := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_version'));
      Pointer(cairo_version_string) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_version_string'));
      Pointer(cairo_create)        := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_create'));
      Pointer(cairo_reference)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_reference'));
      Pointer(cairo_destroy)       := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_destroy'));
      Pointer(cairo_get_reference_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_reference_count'));
      Pointer(cairo_get_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_user_data'));
      Pointer(cairo_set_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_user_data'));
      Pointer(cairo_save)          := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_save'));
      Pointer(cairo_restore)       := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_restore'));
      Pointer(cairo_push_group)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_push_group'));
      Pointer(cairo_push_group_with_content) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_push_group_with_content'));
      Pointer(cairo_pop_group)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pop_group'));
      Pointer(cairo_pop_group_to_source) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pop_group_to_source'));
      Pointer(cairo_set_operator)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_operator'));
      Pointer(cairo_set_source)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_source'));
      Pointer(cairo_set_source_rgb) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_source_rgb'));
      Pointer(cairo_set_source_rgba) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_source_rgba'));
      Pointer(cairo_set_source_surface) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_source_surface'));
      Pointer(cairo_set_tolerance) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_tolerance'));
      Pointer(cairo_set_antialias) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_antialias'));
      Pointer(cairo_set_fill_rule) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_fill_rule'));
      Pointer(cairo_set_line_width) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_line_width'));
      Pointer(cairo_set_line_cap)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_line_cap'));
      Pointer(cairo_set_line_join) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_line_join'));
      Pointer(cairo_set_dash)      := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_dash'));
      Pointer(cairo_set_miter_limit) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_miter_limit'));
      Pointer(cairo_translate)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_translate'));
      Pointer(cairo_scale)         := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scale'));
      Pointer(cairo_rotate)        := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_rotate'));
      Pointer(cairo_transform)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_transform'));
      Pointer(cairo_set_matrix)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_matrix'));
      Pointer(cairo_identity_matrix) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_identity_matrix'));
      Pointer(cairo_user_to_device) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_to_device'));
      Pointer(cairo_device_to_user) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_to_user'));
      Pointer(cairo_device_to_user_distance) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_to_user_distance'));
      Pointer(cairo_new_path)      := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_new_path'));
      Pointer(cairo_move_to)       := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_move_to'));
      Pointer(cairo_new_sub_path)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_new_sub_path'));
      Pointer(cairo_line_to)       := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_line_to'));
      Pointer(cairo_curve_to)      := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_curve_to'));
      Pointer(cairo_rectangle)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_rectangle'));
      Pointer(cairo_close_path)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_close_path'));
      Pointer(cairo_path_extents)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_path_extents'));
      Pointer(cairo_paint)         := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_paint'));
      Pointer(cairo_paint_with_alpha) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_paint_with_alpha'));
      Pointer(cairo_mask)          := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mask'));
      Pointer(cairo_stroke)        := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_stroke'));
      Pointer(cairo_fill)          := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_fill'));
      Pointer(cairo_fill_preserve) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_fill_preserve'));
      Pointer(cairo_copy_page)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_copy_page'));
      Pointer(cairo_show_page)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_show_page'));
      Pointer(cairo_in_stroke)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_in_stroke'));
      Pointer(cairo_in_fill)       := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_in_fill'));
      Pointer(cairo_in_clip)       := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_in_clip'));
      Pointer(cairo_stroke_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_stroke_extents'));
      Pointer(cairo_fill_extents)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_fill_extents'));
      Pointer(cairo_reset_clip)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_reset_clip'));
      Pointer(cairo_clip)          := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_clip'));
      Pointer(cairo_clip_preserve) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_clip_preserve'));
      Pointer(cairo_clip_extents)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_clip_extents'));
      Pointer(cairo_copy_clip_rectangle_list) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_copy_clip_rectangle_list'));
      Pointer(cairo_rectangle_list_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_rectangle_list_destroy'));
      Pointer(cairo_glyph_allocate) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_glyph_allocate'));
      Pointer(cairo_glyph_free)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_glyph_free'));
      Pointer(cairo_text_cluster_allocate) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_text_cluster_allocate'));
      Pointer(cairo_text_cluster_free) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_text_cluster_free'));
      Pointer(cairo_font_options_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_create'));
      Pointer(cairo_font_options_copy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_copy'));
      Pointer(cairo_font_options_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_destroy'));
      Pointer(cairo_font_options_status) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_status'));
      Pointer(cairo_font_options_merge) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_merge'));
      Pointer(cairo_font_options_equal) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_equal'));
      Pointer(cairo_font_options_hash) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_hash'));
      Pointer(cairo_font_options_set_antialias) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_set_antialias'));
      Pointer(cairo_font_options_get_antialias) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_get_antialias'));
      Pointer(cairo_font_options_set_subpixel_order) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_set_subpixel_order'));
      Pointer(cairo_font_options_get_subpixel_order) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_get_subpixel_order'));
      Pointer(cairo_font_options_set_hint_style) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_set_hint_style'));
      Pointer(cairo_font_options_get_hint_style) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_get_hint_style'));
      Pointer(cairo_font_options_set_hint_metrics) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_set_hint_metrics'));
      Pointer(cairo_font_options_get_hint_metrics) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_options_get_hint_metrics'));
      Pointer(cairo_select_font_face) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_select_font_face'));
      Pointer(cairo_set_font_size) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_font_size'));
      Pointer(cairo_set_font_matrix) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_font_matrix'));
      Pointer(cairo_get_font_matrix) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_font_matrix'));
      Pointer(cairo_set_font_options) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_font_options'));
      Pointer(cairo_get_font_options) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_font_options'));
      Pointer(cairo_set_font_face) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_font_face'));
      Pointer(cairo_get_font_face) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_font_face'));
      Pointer(cairo_set_scaled_font) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_set_scaled_font'));
      Pointer(cairo_get_scaled_font) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_scaled_font'));
      Pointer(cairo_show_glyphs)   := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_show_glyphs'));
      Pointer(cairo_text_path)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_text_path'));
      Pointer(cairo_text_extents)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_text_extents'));
      Pointer(cairo_glyph_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_glyph_extents'));
      Pointer(cairo_font_extents)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_extents'));
      Pointer(cairo_font_face_reference) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_face_reference'));
      Pointer(cairo_font_face_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_face_destroy'));
      Pointer(cairo_font_face_get_reference_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_face_get_reference_count'));
      Pointer(cairo_font_face_status) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_face_status'));
      Pointer(cairo_font_face_get_type) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_face_get_type'));
      Pointer(cairo_font_face_get_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_face_get_user_data'));
      Pointer(cairo_font_face_set_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_font_face_set_user_data'));
      Pointer(cairo_scaled_font_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_create'));
      Pointer(cairo_scaled_font_reference) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_reference'));
      Pointer(cairo_scaled_font_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_destroy'));
      Pointer(cairo_scaled_font_get_reference_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_reference_count'));
      Pointer(cairo_scaled_font_status) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_status'));
      Pointer(cairo_scaled_font_get_type) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_type'));
      Pointer(cairo_scaled_font_get_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_user_data'));
      Pointer(cairo_scaled_font_set_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_set_user_data'));
      Pointer(cairo_scaled_font_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_extents'));
      Pointer(cairo_scaled_font_text_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_text_extents'));
      Pointer(cairo_scaled_font_glyph_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_glyph_extents'));
      Pointer(cairo_scaled_font_text_to_glyphs) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_text_to_glyphs'));
      Pointer(cairo_scaled_font_get_font_face) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_font_face'));
      Pointer(cairo_scaled_font_get_font_matrix) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_font_matrix'));
      Pointer(cairo_scaled_font_get_ctm) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_ctm'));
      Pointer(cairo_scaled_font_get_scale_matrix) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_scale_matrix'));
      Pointer(cairo_scaled_font_get_font_options) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_scaled_font_get_font_options'));
      Pointer(cairo_toy_font_face_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_toy_font_face_create'));
      Pointer(cairo_toy_font_face_get_family) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_toy_font_face_get_family'));
      Pointer(cairo_toy_font_face_get_slant) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_toy_font_face_get_slant'));
      Pointer(cairo_toy_font_face_get_weight) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_toy_font_face_get_weight'));
      Pointer(cairo_user_font_face_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_create'));
      Pointer(cairo_user_font_face_set_init_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_set_init_func'));
      Pointer(cairo_user_font_face_set_render_glyph_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_set_render_glyph_func'));
      Pointer(cairo_user_font_face_set_text_to_glyphs_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_set_text_to_glyphs_func'));
      Pointer(cairo_user_font_face_set_unicode_to_glyph_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_set_unicode_to_glyph_func'));
      Pointer(cairo_user_font_face_get_init_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_get_init_func'));
      Pointer(cairo_user_font_face_get_render_glyph_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_get_render_glyph_func'));
      Pointer(cairo_user_font_face_get_text_to_glyphs_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_get_text_to_glyphs_func'));
      Pointer(cairo_user_font_face_get_unicode_to_glyph_func) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_user_font_face_get_unicode_to_glyph_func'));
      Pointer(cairo_get_operator)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_operator'));
      Pointer(cairo_get_source)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_source'));
      Pointer(cairo_get_tolerance) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_tolerance'));
      Pointer(cairo_get_antialias) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_antialias'));
      Pointer(cairo_get_current_point) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_current_point'));
      Pointer(cairo_get_fill_rule) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_fill_rule'));
      Pointer(cairo_get_line_width) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_line_width'));
      Pointer(cairo_get_line_cap)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_line_cap'));
      Pointer(cairo_get_line_join) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_line_join'));
      Pointer(cairo_get_miter_limit) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_miter_limit'));
      Pointer(cairo_get_dash_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_dash_count'));
      Pointer(cairo_get_dash)      := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_dash'));
      Pointer(cairo_get_matrix)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_matrix'));
      Pointer(cairo_get_target)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_target'));
      Pointer(cairo_get_group_target) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_get_group_target'));
      Pointer(cairo_copy_path)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_copy_path'));
      Pointer(cairo_copy_path_flat) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_copy_path_flat'));
      Pointer(cairo_append_path)   := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_append_path'));
      Pointer(cairo_path_destroy)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_path_destroy'));
      Pointer(cairo_status)        := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_status'));
      Pointer(cairo_status_to_string) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_status_to_string'));
      Pointer(cairo_surface_create_similar) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_create_similar'));
      Pointer(cairo_surface_create_similar_image) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_create_similar_image'));
      Pointer(cairo_surface_map_to_image) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_map_to_image'));
      Pointer(cairo_surface_unmap_image) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_unmap_image'));
      Pointer(cairo_surface_create_for_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_create_for_rectangle'));
      Pointer(cairo_surface_create_observer) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_create_observer'));
      Pointer(cairo_surface_observer_add_paint_callback) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_add_paint_callback'));
      Pointer(cairo_surface_observer_add_mask_callback) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_add_mask_callback'));
      Pointer(cairo_surface_observer_add_fill_callback) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_add_fill_callback'));
      Pointer(cairo_surface_observer_add_stroke_callback) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_add_stroke_callback'));
      Pointer(cairo_surface_observer_add_glyphs_callback) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_add_glyphs_callback'));
      Pointer(cairo_surface_observer_add_flush_callback) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_add_flush_callback'));
      Pointer(cairo_surface_observer_add_finish_callback) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_add_finish_callback'));
      Pointer(cairo_surface_observer_print) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_print'));
      Pointer(cairo_surface_observer_elapsed) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_observer_elapsed'));
      Pointer(cairo_device_observer_print) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_observer_print'));
      Pointer(cairo_device_observer_elapsed) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_observer_elapsed'));
      Pointer(cairo_device_observer_paint_elapsed) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_observer_paint_elapsed'));
      Pointer(cairo_device_observer_mask_elapsed) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_observer_mask_elapsed'));
      Pointer(cairo_device_observer_fill_elapsed) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_observer_fill_elapsed'));
      Pointer(cairo_device_observer_stroke_elapsed) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_observer_stroke_elapsed'));
      Pointer(cairo_device_observer_glyphs_elapsed) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_observer_glyphs_elapsed'));
      Pointer(cairo_surface_reference) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_reference'));
      Pointer(cairo_surface_finish) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_finish'));
      Pointer(cairo_surface_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_destroy'));
      Pointer(cairo_surface_get_device) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_device'));
      Pointer(cairo_surface_get_reference_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_reference_count'));
      Pointer(cairo_surface_status) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_status'));
      Pointer(cairo_surface_get_type) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_type'));
      Pointer(cairo_surface_get_content) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_content'));
      Pointer(cairo_surface_write_to_png) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_write_to_png'));
      Pointer(cairo_surface_write_to_png_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_write_to_png_stream'));
      Pointer(cairo_surface_get_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_user_data'));
      Pointer(cairo_surface_set_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_set_user_data'));
      Pointer(cairo_surface_get_mime_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_mime_data'));
      Pointer(cairo_surface_set_mime_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_set_mime_data'));
      Pointer(cairo_surface_supports_mime_type) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_supports_mime_type'));
      Pointer(cairo_surface_get_font_options) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_font_options'));
      Pointer(cairo_surface_flush) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_flush'));
      Pointer(cairo_surface_mark_dirty) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_mark_dirty'));
      Pointer(cairo_surface_mark_dirty_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_mark_dirty_rectangle'));
      Pointer(cairo_surface_set_device_offset) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_set_device_offset'));
      Pointer(cairo_surface_get_device_offset) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_device_offset'));
      Pointer(cairo_surface_set_fallback_resolution) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_set_fallback_resolution'));
      Pointer(cairo_surface_get_fallback_resolution) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_get_fallback_resolution'));
      Pointer(cairo_surface_copy_page) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_copy_page'));
      Pointer(cairo_surface_show_page) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_show_page'));
      Pointer(cairo_surface_has_show_text_glyphs) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_surface_has_show_text_glyphs'));
      Pointer(cairo_image_surface_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_create'));
      Pointer(cairo_format_stride_for_width) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_format_stride_for_width'));
      Pointer(cairo_image_surface_create_for_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_create_for_data'));
      Pointer(cairo_image_surface_get_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_get_data'));
      Pointer(cairo_image_surface_get_format) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_get_format'));
      Pointer(cairo_image_surface_get_width) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_get_width'));
      Pointer(cairo_image_surface_get_height) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_get_height'));
      Pointer(cairo_image_surface_get_stride) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_get_stride'));
      Pointer(cairo_image_surface_create_from_png) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_create_from_png'));
      Pointer(cairo_image_surface_create_from_png_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_image_surface_create_from_png_stream'));
      Pointer(cairo_recording_surface_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_recording_surface_create'));
      Pointer(cairo_recording_surface_ink_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_recording_surface_ink_extents'));
      Pointer(cairo_recording_surface_get_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_recording_surface_get_extents'));
      Pointer(cairo_pattern_create_raster_source) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_create_raster_source'));
      Pointer(cairo_raster_source_pattern_set_callback_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_set_callback_data'));
      Pointer(cairo_raster_source_pattern_get_callback_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_get_callback_data'));
      Pointer(cairo_raster_source_pattern_set_acquire) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_set_acquire'));
      Pointer(cairo_raster_source_pattern_get_acquire) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_get_acquire'));
      Pointer(cairo_raster_source_pattern_set_snapshot) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_set_snapshot'));
      Pointer(cairo_raster_source_pattern_get_snapshot) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_get_snapshot'));
      Pointer(cairo_raster_source_pattern_set_copy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_set_copy'));
      Pointer(cairo_raster_source_pattern_get_copy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_get_copy'));
      Pointer(cairo_raster_source_pattern_set_finish) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_set_finish'));
      Pointer(cairo_raster_source_pattern_get_finish) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_raster_source_pattern_get_finish'));
      Pointer(cairo_pattern_create_rgb) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_create_rgb'));
      Pointer(cairo_pattern_create_rgba) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_create_rgba'));
      Pointer(cairo_pattern_create_for_surface) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_create_for_surface'));
      Pointer(cairo_pattern_create_linear) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_create_linear'));
      Pointer(cairo_pattern_create_radial) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_create_radial'));
      Pointer(cairo_pattern_create_mesh) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_create_mesh'));
      Pointer(cairo_pattern_reference) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_reference'));
      Pointer(cairo_pattern_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_destroy'));
      Pointer(cairo_pattern_get_reference_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_reference_count'));
      Pointer(cairo_pattern_status) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_status'));
      Pointer(cairo_pattern_get_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_user_data'));
      Pointer(cairo_pattern_set_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_set_user_data'));
      Pointer(cairo_pattern_get_type) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_type'));
      Pointer(cairo_pattern_add_color_stop_rgb) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_add_color_stop_rgb'));
      Pointer(cairo_pattern_add_color_stop_rgba) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_add_color_stop_rgba'));
      Pointer(cairo_mesh_pattern_begin_patch) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_begin_patch'));
      Pointer(cairo_mesh_pattern_end_patch) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_end_patch'));
      Pointer(cairo_mesh_pattern_curve_to) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_curve_to'));
      Pointer(cairo_mesh_pattern_line_to) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_line_to'));
      Pointer(cairo_mesh_pattern_move_to) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_move_to'));
      Pointer(cairo_mesh_pattern_set_control_point) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_set_control_point'));
      Pointer(cairo_mesh_pattern_set_corner_color_rgb) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_set_corner_color_rgb'));
      Pointer(cairo_mesh_pattern_set_corner_color_rgba) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_set_corner_color_rgba'));
      Pointer(cairo_pattern_set_matrix) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_set_matrix'));
      Pointer(cairo_pattern_get_matrix) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_matrix'));
      Pointer(cairo_pattern_set_extend) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_set_extend'));
      Pointer(cairo_pattern_get_extend) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_extend'));
      Pointer(cairo_pattern_set_filter) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_set_filter'));
      Pointer(cairo_pattern_get_filter) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_filter'));
      Pointer(cairo_pattern_get_rgba) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_rgba'));
      Pointer(cairo_pattern_get_surface) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_surface'));
      Pointer(cairo_pattern_get_color_stop_rgba) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_color_stop_rgba'));
      Pointer(cairo_pattern_get_color_stop_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_color_stop_count'));
      Pointer(cairo_pattern_get_linear_points) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_linear_points'));
      Pointer(cairo_pattern_get_radial_circles) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pattern_get_radial_circles'));
      Pointer(cairo_mesh_pattern_get_patch_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_get_patch_count'));
      Pointer(cairo_mesh_pattern_get_path) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_get_path'));
      Pointer(cairo_mesh_pattern_get_corner_color_rgba) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_get_corner_color_rgba'));
      Pointer(cairo_mesh_pattern_get_control_point) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_mesh_pattern_get_control_point'));
      Pointer(cairo_matrix_init)   := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_init'));
      Pointer(cairo_matrix_init_identity) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_init_identity'));
      Pointer(cairo_matrix_init_translate) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_init_translate'));
      Pointer(cairo_matrix_init_scale) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_init_scale'));
      Pointer(cairo_matrix_init_rotate) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_init_rotate'));
      Pointer(cairo_matrix_translate) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_translate'));
      Pointer(cairo_matrix_scale)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_scale'));
      Pointer(cairo_matrix_rotate) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_rotate'));
      Pointer(cairo_matrix_invert) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_invert'));
      Pointer(cairo_matrix_multiply) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_multiply'));
      Pointer(cairo_matrix_transform_distance) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_transform_distance'));
      Pointer(cairo_matrix_transform_point) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_matrix_transform_point'));
      Pointer(cairo_region_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_create'));
      Pointer(cairo_region_create_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_create_rectangle'));
      Pointer(cairo_region_create_rectangles) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_create_rectangles'));
      Pointer(cairo_region_copy)   := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_copy'));
      Pointer(cairo_region_reference) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_reference'));
      Pointer(cairo_region_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_destroy'));
      Pointer(cairo_region_equal)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_equal'));
      Pointer(cairo_region_status) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_status'));
      Pointer(cairo_region_get_extents) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_get_extents'));
      Pointer(cairo_region_num_rectangles) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_num_rectangles'));
      Pointer(cairo_region_get_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_get_rectangle'));
      Pointer(cairo_region_is_empty) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_is_empty'));
      Pointer(cairo_region_contains_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_contains_rectangle'));
      Pointer(cairo_region_contains_point) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_contains_point'));
      Pointer(cairo_region_translate) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_translate'));
      Pointer(cairo_region_subtract) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_subtract'));
      Pointer(cairo_region_subtract_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_subtract_rectangle'));
      Pointer(cairo_region_intersect) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_intersect'));
      Pointer(cairo_region_intersect_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_intersect_rectangle'));
      Pointer(cairo_region_union)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_union'));
      Pointer(cairo_region_union_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_union_rectangle'));
      Pointer(cairo_region_xor)    := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_xor'));
      Pointer(cairo_region_xor_rectangle) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_region_xor_rectangle'));
      Pointer(cairo_pdf_surface_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pdf_surface_create'));
      Pointer(cairo_pdf_surface_create_for_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pdf_surface_create_for_stream'));
      Pointer(cairo_pdf_surface_restrict_to_version) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pdf_surface_restrict_to_version'));
      Pointer(cairo_pdf_get_versions) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pdf_get_versions'));
      Pointer(cairo_pdf_version_to_string) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pdf_version_to_string'));
      Pointer(cairo_pdf_surface_set_size) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_pdf_surface_set_size'));
      Pointer(cairo_ps_surface_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_create'));
      Pointer(cairo_ps_surface_create_for_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_create_for_stream'));
      Pointer(cairo_ps_surface_restrict_to_level) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_restrict_to_level'));
      Pointer(cairo_ps_get_levels) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_get_levels'));
      Pointer(cairo_ps_level_to_string) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_level_to_string'));
      Pointer(cairo_ps_surface_set_eps) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_set_eps'));
      Pointer(cairo_ps_surface_get_eps) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_get_eps'));
      Pointer(cairo_ps_surface_set_size) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_set_size'));
      Pointer(cairo_ps_surface_dsc_comment) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_dsc_comment'));
      Pointer(cairo_ps_surface_dsc_begin_setup) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_dsc_begin_setup'));
      Pointer(cairo_ps_surface_dsc_begin_page_setup) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_ps_surface_dsc_begin_page_setup'));
      Pointer(cairo_svg_surface_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_svg_surface_create'));
      Pointer(cairo_svg_surface_create_for_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_svg_surface_create_for_stream'));
      Pointer(cairo_svg_surface_restrict_to_version) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_svg_surface_restrict_to_version'));
      Pointer(cairo_svg_get_versions) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_svg_get_versions'));
      Pointer(cairo_svg_version_to_string) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_svg_version_to_string'));
      Pointer(cairo_tee_surface_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_tee_surface_create'));
      Pointer(cairo_tee_surface_add) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_tee_surface_add'));
      Pointer(cairo_tee_surface_remove) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_tee_surface_remove'));
      Pointer(cairo_tee_surface_index) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_tee_surface_index'));
      Pointer(cairo_arc_negative)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_arc_negative'));
      Pointer(cairo_arc)           := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_arc'));
      Pointer(cairo_show_text)     := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_show_text'));
      Pointer(cairo_device_reference) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_reference'));
      Pointer(cairo_device_get_type) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_get_type'));
      Pointer(cairo_device_status) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_status'));
      Pointer(cairo_device_acquire) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_acquire'));
      Pointer(cairo_device_release) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_release'));
      Pointer(cairo_device_flush)  := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_flush'));
      Pointer(cairo_device_finish) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_finish'));
      Pointer(cairo_device_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_destroy'));
      Pointer(cairo_device_get_reference_count) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_get_reference_count'));
      Pointer(cairo_device_get_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_get_user_data'));
      Pointer(cairo_device_set_user_data) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_device_set_user_data'));
      Pointer(cairo_script_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_create'));
      Pointer(cairo_script_create_for_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_create_for_stream'));
      Pointer(cairo_script_write_comment) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_write_comment'));
      Pointer(cairo_script_set_mode) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_set_mode'));
      Pointer(cairo_script_get_mode) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_get_mode'));
      Pointer(cairo_script_surface_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_surface_create'));
      Pointer(cairo_script_surface_create_for_target) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_surface_create_for_target'));
      Pointer(cairo_script_from_recording_surface) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_from_recording_surface'));
      Pointer(cairo_script_interpreter_create) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_create'));
      Pointer(cairo_script_interpreter_install_hooks) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_install_hooks'));
      Pointer(cairo_script_interpreter_run) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_run'));
      Pointer(cairo_script_interpreter_feed_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_feed_stream'));
      Pointer(cairo_script_interpreter_feed_string) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_feed_string'));
      Pointer(cairo_script_interpreter_get_line_number) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_get_line_number'));
      Pointer(cairo_script_interpreter_reference) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_reference'));
      Pointer(cairo_script_interpreter_finish) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_finish'));
      Pointer(cairo_script_interpreter_destroy) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_destroy'));
      Pointer(cairo_script_interpreter_translate_stream) := DynLibs.GetProcedureAddress(ca_Handle, PChar('cairo_script_interpreter_translate_stream'));
    end;
    Result := ca_IsLoaded;
    ReferenceCounter := 1;
  end;

end;

procedure ca_Unload;
begin
  // < Reference counting
  if ReferenceCounter > 0 then
    Dec(ReferenceCounter);
  if ReferenceCounter > 0 then
    Exit;
    // >
  if ca_IsLoaded then
  begin
    // Pa_Terminate();
    DynLibs.UnloadLibrary(ca_Handle);
    ca_Handle := DynLibs.NilHandle;
  end;
end;

procedure cairo_version_decode(out major, minor, micro: longint);
var
  version: longint;
begin
  version := cairo_version();
  major   := version div 10000;
  minor   := (version mod (major * 10000)) div 100;
  micro   := (version mod ((major * 10000) + (minor * 100)));
end;


end.

