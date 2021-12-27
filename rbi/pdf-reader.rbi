# typed: strong
module PDF
  class Reader
    sig { returns(T.untyped) }
    attr_reader :objects

    sig { params(input: T.any(String, IO), opts: T::Hash[T.untyped, T.untyped]).void }
    def initialize(input, opts = {}); end

    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    def info; end

    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    def metadata; end

    sig { returns(Integer) }
    def page_count; end

    sig { returns(Float) }
    def pdf_version; end

    sig { params(input: T.any(String, IO), opts: T::Hash[T.untyped, T.untyped], block: T.proc.params(arg0: PDF::Reader).void).returns(T.untyped) }
    def self.open(input, opts = {}, &block); end

    sig { returns(T::Array[PDF::Reader::Page]) }
    def pages; end

    sig { params(num: Integer).returns(PDF::Reader::Page) }
    def page(num); end

    sig { params(obj: T.untyped).returns(T.untyped) }
    def doc_strings_to_utf8(obj); end

    sig { params(str: String).returns(T::Boolean)}
    def has_utf16_bom?(str); end

    sig { params(obj: String).returns(String) }
    def pdfdoc_to_utf8(obj); end

    sig { params(obj: String).returns(String) }
    def utf16_to_utf8(obj); end

    sig { returns(T::Hash[Symbol, T.untyped]) }
    def root; end

    class BoundingRectangleRunsFilter
      extend T::Sig

      sig { params(runs: T::Array[PDF::Reader::TextRun], rect: PDF::Reader::Rectangle).returns(T::Array[PDF::Reader::TextRun]) }
      def self.runs_within_rect(runs, rect); end
    end

    class Buffer
      TOKEN_WHITESPACE = [0x00, 0x09, 0x0A, 0x0C, 0x0D, 0x20]
      TOKEN_DELIMITER = [0x25, 0x3C, 0x3E, 0x28, 0x5B, 0x7B, 0x29, 0x5D, 0x7D, 0x2F]
      LEFT_PAREN = "("
      LESS_THAN = "<"
      STREAM = "stream"
      ID = "ID"
      FWD_SLASH = "/"
      NULL_BYTE = "\x00"
      CR = "\r"
      LF = "\n"
      CRLF = "\r\n"
      WHITE_SPACE = [LF, CR, ' ']
      TRAILING_BYTECOUNT = 5000

      sig { returns(T.untyped) }
      attr_reader :pos

      sig { params(io: T.untyped, opts: T.untyped).void }
      def initialize(io, opts = {}); end

      sig { returns(T.untyped) }
      def empty?; end

      sig { params(bytes: T.untyped, opts: T.untyped).returns(T.untyped) }
      def read(bytes, opts = {}); end

      sig { returns(T.untyped) }
      def token; end

      sig { returns(T.untyped) }
      def find_first_xref_offset; end

      sig { returns(T.untyped) }
      def check_size_is_non_zero; end

      sig { returns(T.untyped) }
      def in_content_stream?; end

      sig { returns(T.untyped) }
      def reset_pos; end

      sig { returns(T.untyped) }
      def save_pos; end

      sig { returns(T.untyped) }
      def prepare_tokens; end

      sig { returns(T.untyped) }
      def state; end

      sig { returns(T.untyped) }
      def merge_indirect_reference; end

      sig { returns(T.untyped) }
      def prepare_inline_token; end

      sig { returns(T.untyped) }
      def prepare_hex_token; end

      sig { returns(T.untyped) }
      def prepare_literal_token; end

      sig { returns(T.untyped) }
      def prepare_regular_token; end

      sig { returns(T.untyped) }
      def peek_byte; end

      sig { params(token: T.untyped).returns(T.untyped) }
      def string_token(token); end
    end

    class CidWidths
      extend Forwardable

      sig { params(default: T.untyped, array: T.untyped).void }
      def initialize(default, array); end

      sig { params(default: T.untyped, array: T.untyped).returns(T.untyped) }
      def parse_array(default, array); end

      sig { params(first: T.untyped, widths: T.untyped).returns(T.untyped) }
      def parse_first_form(first, widths); end

      sig { params(first: T.untyped, final: T.untyped, width: T.untyped).returns(T.untyped) }
      def parse_second_form(first, final, width); end
    end

    class CMap
      extend T::Sig
      CMAP_KEYWORDS = {
      "begincodespacerange" => 1,
      "endcodespacerange" => 1,
      "beginbfchar" => 1,
      "endbfchar" => 1,
      "beginbfrange" => 1,
      "endbfrange" => 1,
      "begin" => 1,
      "begincmap" => 1,
      "def" => 1
    }

      sig { returns(T.untyped) }
      attr_reader :map

      sig { params(data: String).void }
      def initialize(data); end

      sig { params(data: String).void }
      def process_data(data); end

      sig { returns(Integer) }
      def size; end

      sig { params(c: T.untyped).returns(T.untyped) }
      def decode(c); end

      sig { params(instructions: T.untyped).returns(T.untyped) }
      def build_parser(instructions); end

      sig { params(str: T.untyped).returns(T.untyped) }
      def str_to_int(str); end

      sig { params(instructions: T.untyped).returns(T.untyped) }
      def process_bfchar_instructions(instructions); end

      sig { params(instructions: T.untyped).returns(T.untyped) }
      def process_bfrange_instructions(instructions); end

      sig { params(start_code: T.untyped, end_code: T.untyped, dst: T.untyped).returns(T.untyped) }
      def bfrange_type_one(start_code, end_code, dst); end

      sig { params(start_code: T.untyped, end_code: T.untyped, dst: T.untyped).returns(T.untyped) }
      def bfrange_type_two(start_code, end_code, dst); end
    end

    class Encoding
      CONTROL_CHARS = [0,1,2,3,4,5,6,7,8,11,12,14,15,16,17,18,19,20,21,22,23,
                     24,25,26,27,28,29,30,31]
      UNKNOWN_CHAR = 0x25AF

      sig { returns(T.untyped) }
      attr_reader :unpack

      sig { params(enc: T.untyped).void }
      def initialize(enc); end

      sig { params(diff: T.untyped).returns(T.untyped) }
      def differences=(diff); end

      sig { returns(T.untyped) }
      def differences; end

      sig { params(str: T.untyped).returns(T.untyped) }
      def to_utf8(str); end

      sig { params(glyph_code: T.untyped).returns(T.untyped) }
      def int_to_utf8_string(glyph_code); end

      sig { params(glyph_code: T.untyped).returns(T.untyped) }
      def int_to_name(glyph_code); end

      sig { returns(T.untyped) }
      def default_mapping; end

      sig { params(glyph_code: T.untyped).returns(T.untyped) }
      def internal_int_to_utf8_string(glyph_code); end

      sig { returns(T.untyped) }
      def utf8_conversion_impossible?; end

      sig { params(times: T.untyped).returns(T.untyped) }
      def little_boxes(times); end

      sig { params(str: T.untyped).returns(T.untyped) }
      def convert_to_utf8(str); end

      sig { params(enc: T.untyped).returns(T.untyped) }
      def get_unpack(enc); end

      sig { params(enc: T.untyped).returns(T.untyped) }
      def get_mapping_file(enc); end

      sig { returns(T.untyped) }
      def glyphlist; end

      sig { params(file: T.untyped).returns(T.untyped) }
      def load_mapping(file); end
    end

    class Error
      sig { params(lvalue: T.untyped, rvalue: T.untyped, chars: T.untyped).returns(T.untyped) }
      def self.str_assert(lvalue, rvalue, chars = nil); end

      sig { params(lvalue: T.untyped, rvalue: T.untyped, chars: T.untyped).returns(T.untyped) }
      def self.str_assert_not(lvalue, rvalue, chars = nil); end

      sig { params(lvalue: T.untyped, rvalue: T.untyped).returns(T.untyped) }
      def self.assert_equal(lvalue, rvalue); end

      sig { params(object: Object, name: String, klass: Module).void }
      def self.validate_type(object, name, klass); end

      sig { params(object: Object, name: String).void }
		  def self.validate_not_nil(object, name); end
    end

    class MalformedPDFError < RuntimeError
    end

    class InvalidPageError < ArgumentError
    end

    class InvalidObjectError < MalformedPDFError
    end

    class UnsupportedFeatureError < RuntimeError
    end

    class EncryptedPDFError < UnsupportedFeatureError
    end

    class Font
      sig { returns(T.untyped) }
      attr_accessor :subtype

      sig { returns(T.untyped) }
      attr_accessor :encoding

      sig { returns(T.untyped) }
      attr_accessor :descendantfonts

      sig { returns(T.untyped) }
      attr_accessor :tounicode

      sig { returns(T.untyped) }
      attr_reader :widths

      sig { returns(T.untyped) }
      attr_reader :first_char

      sig { returns(T.untyped) }
      attr_reader :last_char

      sig { returns(T.untyped) }
      attr_reader :basefont

      sig { returns(T.untyped) }
      attr_reader :font_descriptor

      sig { returns(T.untyped) }
      attr_reader :cid_widths

      sig { returns(T.untyped) }
      attr_reader :cid_default_width

      sig { params(ohash: T.untyped, obj: T.untyped).void }
      def initialize(ohash, obj); end

      sig { params(params: T.untyped).returns(T.untyped) }
      def to_utf8(params); end

      sig { params(data: T.untyped).returns(T.untyped) }
      def unpack(data); end

      sig { params(code_point: T.untyped).returns(T.untyped) }
      def glyph_width(code_point); end

      sig { params(font_name: T.untyped).returns(T.untyped) }
      def default_encoding(font_name); end

      sig { returns(T.untyped) }
      def build_width_calculator; end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def extract_base_info(obj); end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def extract_descriptor(obj); end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def extract_descendants(obj); end

      sig { params(params: T.untyped).returns(T.untyped) }
      def to_utf8_via_cmap(params); end

      sig { params(params: T.untyped).returns(T.untyped) }
      def to_utf8_via_encoding(params); end
    end

    class FontDescriptor
      sig { returns(T.untyped) }
      attr_reader :font_name

      sig { returns(T.untyped) }
      attr_reader :font_family

      sig { returns(T.untyped) }
      attr_reader :font_stretch

      sig { returns(T.untyped) }
      attr_reader :font_weight

      sig { returns(T.untyped) }
      attr_reader :font_bounding_box

      sig { returns(T.untyped) }
      attr_reader :cap_height

      sig { returns(T.untyped) }
      attr_reader :ascent

      sig { returns(T.untyped) }
      attr_reader :descent

      sig { returns(T.untyped) }
      attr_reader :leading

      sig { returns(T.untyped) }
      attr_reader :avg_width

      sig { returns(T.untyped) }
      attr_reader :max_width

      sig { returns(T.untyped) }
      attr_reader :missing_width

      sig { returns(T.untyped) }
      attr_reader :italic_angle

      sig { returns(T.untyped) }
      attr_reader :stem_v

      sig { returns(T.untyped) }
      attr_reader :x_height

      sig { returns(T.untyped) }
      attr_reader :font_flags

      sig { params(ohash: T.untyped, fd_hash: T.untyped).void }
      def initialize(ohash, fd_hash); end

      sig { params(char_code: T.untyped).returns(T.untyped) }
      def glyph_width(char_code); end

      sig { returns(T.untyped) }
      def glyph_to_pdf_scale_factor; end

      sig { returns(T.untyped) }
      def ttf_program_stream; end
    end

    class FormXObject
      include ResourceMethods

      sig { returns(T.untyped) }
      attr_reader :xobject

      sig { params(page: T.untyped, xobject: T.untyped, options: T.untyped).void }
      def initialize(page, xobject, options = {}); end

      sig { returns(T.untyped) }
      def font_objects; end

      sig { params(receivers: T.untyped).returns(T.untyped) }
      def walk(*receivers); end

      sig { returns(T.untyped) }
      def raw_content; end

      sig { returns(T.untyped) }
      def resources; end

      sig { params(receivers: T.untyped, name: T.untyped, params: T.untyped).returns(T.untyped) }
      def callback(receivers, name, params = []); end

      sig { returns(T.untyped) }
      def content_stream_md5; end

      sig { returns(T.untyped) }
      def cached_tokens_key; end

      sig { returns(T.untyped) }
      def tokens; end

      sig { params(receivers: T.untyped, instructions: T.untyped).returns(T.untyped) }
      def content_stream(receivers, instructions); end
    end

    class GlyphHash
      sig { void }
      def initialize; end

      sig { params(name: T.untyped).returns(T.untyped) }
      def name_to_unicode(name); end

      sig { params(codepoint: T.untyped).returns(T.untyped) }
      def unicode_to_name(codepoint); end

      sig { returns(T.untyped) }
      def load_adobe_glyph_mapping; end
    end

    class LZW
      CODE_EOD = 257
      CODE_CLEAR_TABLE = 256

      class BitStream
        sig { params(data: T.untyped, bits_in_chunk: T.untyped).void }
        def initialize(data, bits_in_chunk); end

        sig { params(bits_in_chunk: T.untyped).returns(T.untyped) }
        def set_bits_in_chunk(bits_in_chunk); end

        sig { returns(T.untyped) }
        def read; end
      end

      class StringTable < Hash
        sig { returns(T.untyped) }
        attr_reader :string_table_pos

        sig { void }
        def initialize; end

        sig { params(key: T.untyped).returns(T.untyped) }
        def [](key); end

        sig { params(string: T.untyped).returns(T.untyped) }
        def add(string); end
      end

      sig { params(data: T.untyped).returns(T.untyped) }
      def self.decode(data); end

      sig { params(string_table: T.untyped, some_code: T.untyped, other_code: T.untyped).returns(T.untyped) }
      def self.create_new_string(string_table, some_code, other_code); end
    end

    class NullSecurityHandler
      sig { params(encrypt: T.untyped).returns(T.untyped) }
      def self.supports?(encrypt); end

      sig { params(buf: T.untyped, _ref: T.untyped).returns(T.untyped) }
      def decrypt(buf, _ref); end
    end

    class ObjectCache
      CACHEABLE_TYPES = [:Catalog, :Page, :Pages]

      sig { returns(T.untyped) }
      attr_reader :hits

      sig { returns(T.untyped) }
      attr_reader :misses

      sig { params(lru_size: T.untyped).void }
      def initialize(lru_size = 1000); end

      sig { params(key: T.untyped).returns(T.untyped) }
      def [](key); end

      sig { params(key: T.untyped, value: T.untyped).returns(T.untyped) }
      def []=(key, value); end

      sig { params(key: T.untyped, local_default: T.untyped).returns(T.untyped) }
      def fetch(key, local_default = nil); end

      sig { params(block: T.untyped).returns(T.untyped) }
      def each(&block); end

      sig { params(block: T.untyped).returns(T.untyped) }
      def each_key(&block); end

      sig { params(block: T.untyped).returns(T.untyped) }
      def each_value(&block); end

      sig { returns(T.untyped) }
      def size; end

      sig { returns(T.untyped) }
      def empty?; end

      sig { params(key: T.untyped).returns(T.untyped) }
      def include?(key); end

      sig { params(value: T.untyped).returns(T.untyped) }
      def has_value?(value); end

      sig { returns(T.untyped) }
      def to_s; end

      sig { returns(T.untyped) }
      def keys; end

      sig { returns(T.untyped) }
      def values; end

      sig { params(key: T.untyped).returns(T.untyped) }
      def update_stats(key); end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def cacheable?(obj); end
    end

    class ObjectHash
      include Enumerable

      sig { returns(T.untyped) }
      attr_accessor :default

      sig { returns(T.untyped) }
      attr_reader :trailer

      sig { returns(T.untyped) }
      attr_reader :pdf_version

      sig { returns(T.untyped) }
      attr_reader :sec_handler

      sig { params(input: T.untyped, opts: T.untyped).void }
      def initialize(input, opts = {}); end

      sig { params(ref: T.untyped).returns(T.untyped) }
      def obj_type(ref); end

      sig { params(ref: T.untyped).returns(T.untyped) }
      def stream?(ref); end

      sig { params(key: T.untyped).returns(T.untyped) }
      def [](key); end

      sig { params(key: T.untyped).returns(T.untyped) }
      def object(key); end

      sig { params(key: T.untyped).returns(T.untyped) }
      def deref!(key); end

      sig { params(key: T.untyped, local_default: T.untyped).returns(T.untyped) }
      def fetch(key, local_default = nil); end

      sig { params(block: T.untyped).returns(T.untyped) }
      def each(&block); end

      sig { params(block: T.untyped).returns(T.untyped) }
      def each_key(&block); end

      sig { params(block: T.untyped).returns(T.untyped) }
      def each_value(&block); end

      sig { returns(T.untyped) }
      def size; end

      sig { returns(T.untyped) }
      def empty?; end

      sig { params(check_key: T.untyped).returns(T.untyped) }
      def has_key?(check_key); end

      sig { params(value: T.untyped).returns(T.untyped) }
      def has_value?(value); end

      sig { returns(T.untyped) }
      def to_s; end

      sig { returns(T.untyped) }
      def keys; end

      sig { returns(T.untyped) }
      def values; end

      sig { params(ids: T.untyped).returns(T.untyped) }
      def values_at(*ids); end

      sig { returns(T.untyped) }
      def to_a; end

      sig { returns(T.untyped) }
      def page_references; end

      sig { returns(T.untyped) }
      def encrypted?; end

      sig { returns(T.untyped) }
      def sec_handler?; end

      sig { params(key: T.untyped).returns(T.untyped) }
      def fetch_object(key); end

      sig { params(key: T.untyped).returns(T.untyped) }
      def fetch_object_stream(key); end

      sig { params(key: T.untyped, seen: T.untyped).returns(T.untyped) }
      def deref_internal!(key, seen); end

      sig { params(opts: T.untyped).returns(T.untyped) }
      def build_security_handler(opts = {}); end

      sig { params(ref: T.untyped, obj: T.untyped).returns(T.untyped) }
      def decrypt(ref, obj); end

      sig { params(offset: T.untyped).returns(T.untyped) }
      def new_buffer(offset = 0); end

      sig { returns(T.untyped) }
      def xref; end

      sig { returns(T.untyped) }
      def object_streams; end

      sig { params(ref: T.untyped).returns(T.untyped) }
      def get_page_objects(ref); end

      sig { returns(T.untyped) }
      def read_version; end

      sig { params(input: T.untyped).returns(T.untyped) }
      def extract_io_from(input); end

      sig { params(input: T.untyped).returns(T.untyped) }
      def read_as_binary(input); end
    end

    class ObjectStream
      sig { params(stream: T.untyped).void }
      def initialize(stream); end

      sig { params(objid: T.untyped).returns(T.untyped) }
      def [](objid); end

      sig { returns(T.untyped) }
      def size; end

      sig { returns(T.untyped) }
      def offsets; end

      sig { returns(T.untyped) }
      def first; end

      sig { returns(T.untyped) }
      def buffer; end
    end

    class OverlappingRunsFilter
      extend T::Sig
      OVERLAPPING_THRESHOLD = 0.5

      sig { params(runs: T::Array[PDF::Reader::TextRun]).returns(T::Array[PDF::Reader::TextRun]) }
      def self.exclude_redundant_runs(runs); end

      sig { params(sweep_line_status: T::Array[PDF::Reader::TextRun], event_point: EventPoint).returns(T::Boolean) }
      def self.detect_intersection(sweep_line_status, event_point); end
    end

    class EventPoint
      extend T::Sig

      sig { returns(Numeric) }
      attr_reader :x

      sig { returns(PDF::Reader::TextRun) }
      attr_reader :run

      sig { params(x: Numeric, run: PDF::Reader::TextRun).void }
      def initialize(x, run); end

      sig { returns(T::Boolean) }
      def start?; end
    end

    class Page
      include ResourceMethods

      sig { returns(PDF::Reader::ObjectHash) }
      attr_reader :objects

      sig { returns(T.untyped) }
      attr_reader :page_object

      sig { returns(T.untyped) }
      attr_reader :cache

      sig { params(objects: PDF::Reader::ObjectHash, pagenum: Integer, options: T::Hash[Symbol, T.untyped]).void }
      def initialize(objects, pagenum, options = {}); end

      sig { returns(Integer) }
      def number; end

      sig { returns(String) }
      def inspect; end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def attributes; end

      sig { returns(Numeric) }
      def height; end

      sig { returns(Numeric) }
      def width; end

      sig { returns(String) }
      def orientation; end

      sig { returns(T::Array[Numeric]) }
      def origin; end

      sig { params(opts: T::Hash[Symbol, T.untyped]).returns(T::Array[PDF::Reader::TextRun]) }
      def runs(opts = {}); end

      sig { params(opts: T::Hash[Symbol, T.untyped]).returns(String) }
      def text(opts = {}); end

      sig { params(receivers: T.untyped).void }
      def walk(*receivers); end

      sig { returns(String) }
      def raw_content; end

      sig { returns(Integer) }
      def rotate; end

      sig { returns(T::Hash[Symbol, T::Array[Numeric]]) }
      def boxes; end

      sig { returns(T::Hash[Symbol, PDF::Reader::Rectangle]) }
      def rectangles; end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def root; end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def resources; end

      sig { params(receivers: T.untyped, instructions: T.untyped).returns(T.untyped) }
      def content_stream(receivers, instructions); end

      sig { params(receivers: T.untyped, name: T.untyped, params: T.untyped).returns(T.untyped) }
      def callback(receivers, name, params = []); end

      sig { returns(T.untyped) }
      def page_with_ancestors; end

      sig { params(origin: T.untyped).returns(T.untyped) }
      def ancestors(origin = @page_object[:Parent]); end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def select_inheritable(obj); end
    end

    class PageLayout
      extend T::Sig
      DEFAULT_FONT_SIZE = 12

      sig { params(runs: T::Array[PDF::Reader::TextRun], mediabox: T.any(T::Array[Numeric], PDF::Reader::Rectangle)).void }
      def initialize(runs, mediabox); end

      sig { returns(String) }
      def to_s; end

      sig { params(rows: T.untyped).returns(T.untyped) }
      def interesting_rows(rows); end

      sig { returns(T.untyped) }
      def row_count; end

      sig { returns(T.untyped) }
      def col_count; end

      sig { returns(T.untyped) }
      def row_multiplier; end

      sig { returns(T.untyped) }
      def col_multiplier; end

      sig { params(collection: T.untyped).returns(T.untyped) }
      def mean(collection); end

      sig { params(collection: T.untyped).returns(T.untyped) }
      def median(collection); end

      sig { params(runs: T.untyped).returns(T.untyped) }
      def merge_runs(runs); end

      sig { params(chars: T::Array[PDF::Reader::TextRun]).returns(T::Array[PDF::Reader::TextRun]) }
      def group_chars_into_runs(chars); end

      sig { params(haystack: T.untyped, needle: T.untyped, index: T.untyped).returns(T.untyped) }
      def local_string_insert(haystack, needle, index); end

      sig { params(mediabox: T.untyped).returns(T.untyped) }
      def process_mediabox(mediabox); end
    end

    class PageState
      DEFAULT_GRAPHICS_STATE = {
        :char_spacing   => 0,
        :word_spacing   => 0,
        :h_scaling      => 1.0,
        :text_leading   => 0,
        :text_font      => nil,
        :text_font_size => nil,
        :text_mode      => 0,
        :text_rise      => 0,
        :text_knockout  => 0
      }

      sig { params(page: T.untyped).void }
      def initialize(page); end

      sig { returns(T.untyped) }
      def save_graphics_state; end

      sig { returns(T.untyped) }
      def restore_graphics_state; end

      sig do
        params(
          a: T.untyped,
          b: T.untyped,
          c: T.untyped,
          d: T.untyped,
          e: T.untyped,
          f: T.untyped
        ).returns(T.untyped)
      end
      def concatenate_matrix(a, b, c, d, e, f); end

      sig { returns(T.untyped) }
      def begin_text_object; end

      sig { returns(T.untyped) }
      def end_text_object; end

      sig { params(char_spacing: T.untyped).returns(T.untyped) }
      def set_character_spacing(char_spacing); end

      sig { params(h_scaling: T.untyped).returns(T.untyped) }
      def set_horizontal_text_scaling(h_scaling); end

      sig { params(label: T.untyped, size: T.untyped).returns(T.untyped) }
      def set_text_font_and_size(label, size); end

      sig { returns(T.untyped) }
      def font_size; end

      sig { params(leading: T.untyped).returns(T.untyped) }
      def set_text_leading(leading); end

      sig { params(mode: T.untyped).returns(T.untyped) }
      def set_text_rendering_mode(mode); end

      sig { params(rise: T.untyped).returns(T.untyped) }
      def set_text_rise(rise); end

      sig { params(word_spacing: T.untyped).returns(T.untyped) }
      def set_word_spacing(word_spacing); end

      sig { params(x: T.untyped, y: T.untyped).returns(T.untyped) }
      def move_text_position(x, y); end

      sig { params(x: T.untyped, y: T.untyped).returns(T.untyped) }
      def move_text_position_and_set_leading(x, y); end

      sig do
        params(
          a: T.untyped,
          b: T.untyped,
          c: T.untyped,
          d: T.untyped,
          e: T.untyped,
          f: T.untyped
        ).returns(T.untyped)
      end
      def set_text_matrix_and_text_line_matrix(a, b, c, d, e, f); end

      sig { returns(T.untyped) }
      def move_to_start_of_next_line; end

      sig { params(params: T.untyped).returns(T.untyped) }
      def show_text_with_positioning(params); end

      sig { params(str: T.untyped).returns(T.untyped) }
      def move_to_next_line_and_show_text(str); end

      sig { params(aw: T.untyped, ac: T.untyped, string: T.untyped).returns(T.untyped) }
      def set_spacing_next_line_show_text(aw, ac, string); end

      sig { params(label: T.untyped).returns(T.untyped) }
      def invoke_xobject(label); end

      sig { params(x: T.untyped, y: T.untyped).returns(T.untyped) }
      def ctm_transform(x, y); end

      sig { params(x: T.untyped, y: T.untyped).returns(T.untyped) }
      def trm_transform(x, y); end

      sig { returns(T.untyped) }
      def current_font; end

      sig { params(label: T.untyped).returns(T.untyped) }
      def find_font(label); end

      sig { params(label: T.untyped).returns(T.untyped) }
      def find_color_space(label); end

      sig { params(label: T.untyped).returns(T.untyped) }
      def find_xobject(label); end

      sig { returns(T.untyped) }
      def stack_depth; end

      sig { returns(T.untyped) }
      def clone_state; end

      sig { params(w0: T.untyped, tj: T.untyped, word_boundary: T.untyped).returns(T.untyped) }
      def process_glyph_displacement(w0, tj, word_boundary); end

      sig { returns(T.untyped) }
      def text_rendering_matrix; end

      sig { returns(T.untyped) }
      def ctm; end

      sig { returns(T.untyped) }
      def state; end

      sig { params(raw_fonts: T.untyped).returns(T.untyped) }
      def build_fonts(raw_fonts); end

      sig { returns(T.untyped) }
      def identity_matrix; end
    end

    class PageTextReceiver
      extend Forwardable
      SPACE = " "

      sig { returns(T.untyped) }
      attr_reader :state

      sig { returns(T.untyped) }
      attr_reader :options

      sig { params(page: T.untyped).returns(T.untyped) }
      def page=(page); end

      sig { returns(T.untyped) }
      def content; end

      sig { params(string: T.untyped).returns(T.untyped) }
      def show_text(string); end

      sig { params(params: T.untyped).returns(T.untyped) }
      def show_text_with_positioning(params); end

      sig { params(str: T.untyped).returns(T.untyped) }
      def move_to_next_line_and_show_text(str); end

      sig { params(opts: T::Hash[Symbol, T.untyped]).returns(T::Array[PDF::Reader::TextRun]) }
      def runs(opts = {}); end

      sig { params(aw: T.untyped, ac: T.untyped, string: T.untyped).returns(T.untyped) }
      def set_spacing_next_line_show_text(aw, ac, string); end

      sig { params(label: T.untyped).returns(T.untyped) }
      def invoke_xobject(label); end

      sig { params(string: T.untyped).returns(T.untyped) }
      def internal_show_text(string); end

      sig { params(x: T.untyped, y: T.untyped).returns(T.untyped) }
      def apply_rotation(x, y); end
    end

    class PagesStrategy
      OPERATORS = {
      'b'   => :close_fill_stroke,
      'B'   => :fill_stroke,
      'b*'  => :close_fill_stroke_with_even_odd,
      'B*'  => :fill_stroke_with_even_odd,
      'BDC' => :begin_marked_content_with_pl,
      'BI'  => :begin_inline_image,
      'BMC' => :begin_marked_content,
      'BT'  => :begin_text_object,
      'BX'  => :begin_compatibility_section,
      'c'   => :append_curved_segment,
      'cm'  => :concatenate_matrix,
      'CS'  => :set_stroke_color_space,
      'cs'  => :set_nonstroke_color_space,
      'd'   => :set_line_dash,
      'd0'  => :set_glyph_width,
      'd1'  => :set_glyph_width_and_bounding_box,
      'Do'  => :invoke_xobject,
      'DP'  => :define_marked_content_with_pl,
      'EI'  => :end_inline_image,
      'EMC' => :end_marked_content,
      'ET'  => :end_text_object,
      'EX'  => :end_compatibility_section,
      'f'   => :fill_path_with_nonzero,
      'F'   => :fill_path_with_nonzero,
      'f*'  => :fill_path_with_even_odd,
      'G'   => :set_gray_for_stroking,
      'g'   => :set_gray_for_nonstroking,
      'gs'  => :set_graphics_state_parameters,
      'h'   => :close_subpath,
      'i'   => :set_flatness_tolerance,
      'ID'  => :begin_inline_image_data,
      'j'   => :set_line_join_style,
      'J'   => :set_line_cap_style,
      'K'   => :set_cmyk_color_for_stroking,
      'k'   => :set_cmyk_color_for_nonstroking,
      'l'   => :append_line,
      'm'   => :begin_new_subpath,
      'M'   => :set_miter_limit,
      'MP'  => :define_marked_content_point,
      'n'   => :end_path,
      'q'   => :save_graphics_state,
      'Q'   => :restore_graphics_state,
      're'  => :append_rectangle,
      'RG'  => :set_rgb_color_for_stroking,
      'rg'  => :set_rgb_color_for_nonstroking,
      'ri'  => :set_color_rendering_intent,
      's'   => :close_and_stroke_path,
      'S'   => :stroke_path,
      'SC'  => :set_color_for_stroking,
      'sc'  => :set_color_for_nonstroking,
      'SCN' => :set_color_for_stroking_and_special,
      'scn' => :set_color_for_nonstroking_and_special,
      'sh'  => :paint_area_with_shading_pattern,
      'T*'  => :move_to_start_of_next_line,
      'Tc'  => :set_character_spacing,
      'Td'  => :move_text_position,
      'TD'  => :move_text_position_and_set_leading,
      'Tf'  => :set_text_font_and_size,
      'Tj'  => :show_text,
      'TJ'  => :show_text_with_positioning,
      'TL'  => :set_text_leading,
      'Tm'  => :set_text_matrix_and_text_line_matrix,
      'Tr'  => :set_text_rendering_mode,
      'Ts'  => :set_text_rise,
      'Tw'  => :set_word_spacing,
      'Tz'  => :set_horizontal_text_scaling,
      'v'   => :append_curved_segment_initial_point_replicated,
      'w'   => :set_line_width,
      'W'   => :set_clipping_path_with_nonzero,
      'W*'  => :set_clipping_path_with_even_odd,
      'y'   => :append_curved_segment_final_point_replicated,
      '\''  => :move_to_next_line_and_show_text,
      '"'   => :set_spacing_next_line_show_text,
    }
    end

    class Point
      sig do
        params(
          x: Numeric,
          y: Numeric,
        ).void
      end
      def initialize(x, y); end

      sig { returns(Numeric) }
      def x; end

      sig { returns(Numeric) }
      def y; end

      sig { params(other: PDF::Reader::Point).returns(T::Boolean) }
      def ==(other); end

    end

    class PrintReceiver
      sig { returns(T.untyped) }
      attr_accessor :callbacks

      sig { void }
      def initialize; end

      sig { params(meth: T.untyped).returns(T.untyped) }
      def respond_to?(meth); end

      sig { params(methodname: T.untyped, args: T.untyped).returns(T.untyped) }
      def method_missing(methodname, *args); end
    end

    class Rectangle
      sig { params(arr: T::Array[Numeric]).returns(PDF::Reader::Rectangle) }
      def self.from_array(arr); end

      sig do
        params(
          x1: Numeric,
          y1: Numeric,
          x2: Numeric,
          y2: Numeric
        ).void
      end
      def initialize(x1, y1, x2, y2); end

      sig { returns(PDF::Reader::Point) }
      def bottom_left; end

      sig { returns(PDF::Reader::Point) }
      def bottom_right; end

      sig { returns(PDF::Reader::Point) }
      def top_left; end

      sig { returns(PDF::Reader::Point) }
      def top_right; end

      sig { returns(Numeric) }
      def height; end

      sig { returns(Numeric) }
      def width; end

      sig { returns(T::Array[Numeric]) }
      def to_a; end

      sig { params(degrees: Integer).void }
      def apply_rotation(degrees); end
    end

    class Reference
      sig { returns(T.untyped) }
      attr_reader :id

      sig { returns(T.untyped) }
      attr_reader :gen

      sig { params(id: T.untyped, gen: T.untyped).void }
      def initialize(id, gen); end

      sig { returns(T.untyped) }
      def to_a; end

      sig { returns(T.untyped) }
      def to_i; end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def ==(obj); end

      sig { returns(T.untyped) }
      def hash; end
    end

    class RegisterReceiver
      sig { returns(T.untyped) }
      attr_accessor :callbacks

      sig { void }
      def initialize; end

      sig { params(meth: T.untyped).returns(T.untyped) }
      def respond_to?(meth); end

      sig { params(methodname: T.untyped, args: T.untyped).returns(T.untyped) }
      def method_missing(methodname, *args); end

      sig { params(methodname: T.untyped).returns(T.untyped) }
      def count(methodname); end

      sig { params(methodname: T.untyped).returns(T.untyped) }
      def all(methodname); end

      sig { params(methodname: T.untyped).returns(T.untyped) }
      def all_args(methodname); end

      sig { params(methodname: T.untyped).returns(T.untyped) }
      def first_occurance_of(methodname); end

      sig { params(methodname: T.untyped).returns(T.untyped) }
      def final_occurance_of(methodname); end

      sig { params(methods: T.untyped).returns(T.untyped) }
      def series(*methods); end
    end

    module ResourceMethods
      extend T::Helpers

      sig { returns(T.untyped) }
      def color_spaces; end

      sig { returns(T.untyped) }
      def fonts; end

      sig { returns(T.untyped) }
      def graphic_states; end

      sig { returns(T.untyped) }
      def patterns; end

      sig { returns(T.untyped) }
      def procedure_sets; end

      sig { returns(T.untyped) }
      def properties; end

      sig { returns(T.untyped) }
      def shadings; end

      sig { returns(T.untyped) }
      def xobjects; end
    end

    class StandardSecurityHandler
      PassPadBytes = [ 0x28, 0xbf, 0x4e, 0x5e, 0x4e, 0x75, 0x8a, 0x41,
                     0x64, 0x00, 0x4e, 0x56, 0xff, 0xfa, 0x01, 0x08,
                     0x2e, 0x2e, 0x00, 0xb6, 0xd0, 0x68, 0x3e, 0x80,
                     0x2f, 0x0c, 0xa9, 0xfe, 0x64, 0x53, 0x69, 0x7a ]

      sig { returns(T.untyped) }
      attr_reader :key_length

      sig { returns(T.untyped) }
      attr_reader :revision

      sig { returns(T.untyped) }
      attr_reader :encrypt_key

      sig { returns(T.untyped) }
      attr_reader :owner_key

      sig { returns(T.untyped) }
      attr_reader :user_key

      sig { returns(T.untyped) }
      attr_reader :permissions

      sig { returns(T.untyped) }
      attr_reader :file_id

      sig { returns(T.untyped) }
      attr_reader :password

      sig { params(opts: T.untyped).void }
      def initialize(opts = {}); end

      sig { params(encrypt: T.untyped).returns(T.untyped) }
      def self.supports?(encrypt); end

      sig { params(buf: T.untyped, ref: T.untyped).returns(T.untyped) }
      def decrypt(buf, ref); end

      sig { params(buf: T.untyped, ref: T.untyped).returns(T.untyped) }
      def decrypt_rc4(buf, ref); end

      sig { params(buf: T.untyped, ref: T.untyped).returns(T.untyped) }
      def decrypt_aes128(buf, ref); end

      sig { params(p: T.untyped).returns(T.untyped) }
      def pad_pass(p = ""); end

      sig { params(buf: T.untyped, int: T.untyped).returns(T.untyped) }
      def xor_each_byte(buf, int); end

      sig { params(pass: T.untyped).returns(T.untyped) }
      def auth_owner_pass(pass); end

      sig { params(pass: T.untyped).returns(T.untyped) }
      def auth_user_pass(pass); end

      sig { params(user_pass: T.untyped).returns(T.untyped) }
      def make_file_key(user_pass); end

      sig { params(pass: T.untyped).returns(T.untyped) }
      def build_standard_key(pass); end
    end

    class StandardSecurityHandlerV5
      sig { returns(T.untyped) }
      attr_reader :key_length

      sig { returns(T.untyped) }
      attr_reader :encrypt_key

      sig { params(opts: T.untyped).void }
      def initialize(opts = {}); end

      sig { params(encrypt: T.untyped).returns(T.untyped) }
      def self.supports?(encrypt); end

      sig { params(buf: T.untyped, ref: T.untyped).returns(T.untyped) }
      def decrypt(buf, ref); end

      sig { params(password: T.untyped).returns(T.untyped) }
      def auth_owner_pass(password); end

      sig { params(password: T.untyped).returns(T.untyped) }
      def auth_user_pass(password); end

      sig { params(pass: T.untyped).returns(T.untyped) }
      def build_standard_key(pass); end
    end

    class Stream
      sig { returns(T.untyped) }
      attr_accessor :hash

      sig { returns(T.untyped) }
      attr_accessor :data

      sig { params(hash: T.untyped, data: T.untyped).void }
      def initialize(hash, data); end

      sig { returns(T.untyped) }
      def unfiltered_data; end
    end

    class SynchronizedCache
      sig { void }
      def initialize; end

      sig { params(key: T.untyped).returns(T.untyped) }
      def [](key); end

      sig { params(key: T.untyped, value: T.untyped).returns(T.untyped) }
      def []=(key, value); end
    end

    class TextRun
      include Comparable
      extend T::Sig

      sig { returns(T.untyped) }
      attr_reader :x

      sig { returns(T.untyped) }
      attr_reader :y

      sig { returns(T.untyped) }
      attr_reader :width

      sig { returns(T.untyped) }
      attr_reader :font_size

      sig { returns(T.untyped) }
      attr_reader :text

      sig do
        params(
          x: T.untyped,
          y: T.untyped,
          width: T.untyped,
          font_size: T.untyped,
          text: T.untyped
        ).void
      end
      def initialize(x, y, width, font_size, text); end

      sig { params(other: T.untyped).returns(T.untyped) }
      def <=>(other); end

      sig { returns(T.untyped) }
      def endx; end

      sig { returns(T.untyped) }
      def endy; end

      sig { returns(T.untyped) }
      def mean_character_width; end

      sig { params(other: PDF::Reader::TextRun).returns(T::Boolean) }
      def mergable?(other); end

      sig { params(other: PDF::Reader::TextRun).returns(PDF::Reader::TextRun) }
      def +(other); end

      sig { returns(T.untyped) }
      def inspect; end

      sig { params(other_run: T.untyped).returns(T.untyped) }
      def intersect?(other_run); end

      sig { params(other_run: T.untyped).returns(T.untyped) }
      def intersection_area_percent(other_run); end

      sig { returns(T.untyped) }
      def area; end

      sig { returns(T.untyped) }
      def mergable_range; end

      sig { returns(T.untyped) }
      def character_count; end
    end

    class Token < String
      sig { params(val: T.untyped).void }
      def initialize(val); end
    end

    class TransformationMatrix
      sig { returns(T.untyped) }
      attr_reader :a

      sig { returns(T.untyped) }
      attr_reader :b

      sig { returns(T.untyped) }
      attr_reader :c

      sig { returns(T.untyped) }
      attr_reader :d

      sig { returns(T.untyped) }
      attr_reader :e

      sig { returns(T.untyped) }
      attr_reader :f

      sig do
        params(
          a: T.untyped,
          b: T.untyped,
          c: T.untyped,
          d: T.untyped,
          e: T.untyped,
          f: T.untyped
        ).void
      end
      def initialize(a, b, c, d, e, f); end

      sig { returns(T.untyped) }
      def inspect; end

      sig { returns(T.untyped) }
      def to_a; end

      sig do
        params(
          a: T.untyped,
          b: T.untyped,
          c: T.untyped,
          d: T.untyped,
          e: T.untyped,
          f: T.untyped
        ).returns(T.untyped)
      end
      def multiply!(a, b = nil, c = nil, d = nil, e = nil, f = nil); end

      sig { params(e2: T.untyped).returns(T.untyped) }
      def horizontal_displacement_multiply!(e2); end

      sig do
        params(
          a2: T.untyped,
          b2: T.untyped,
          c2: T.untyped,
          d2: T.untyped,
          e2: T.untyped,
          f2: T.untyped
        ).returns(T.untyped)
      end
      def horizontal_displacement_multiply_reversed!(a2, b2, c2, d2, e2, f2); end

      sig do
        params(
          a2: T.untyped,
          b2: T.untyped,
          c2: T.untyped,
          d2: T.untyped,
          e2: T.untyped,
          f2: T.untyped
        ).returns(T.untyped)
      end
      def xy_scaling_multiply!(a2, b2, c2, d2, e2, f2); end

      sig do
        params(
          a2: T.untyped,
          b2: T.untyped,
          c2: T.untyped,
          d2: T.untyped,
          e2: T.untyped,
          f2: T.untyped
        ).returns(T.untyped)
      end
      def xy_scaling_multiply_reversed!(a2, b2, c2, d2, e2, f2); end

      sig do
        params(
          a2: T.untyped,
          b2: T.untyped,
          c2: T.untyped,
          d2: T.untyped,
          e2: T.untyped,
          f2: T.untyped
        ).returns(T.untyped)
      end
      def regular_multiply!(a2, b2, c2, d2, e2, f2); end

      sig do
        params(
          a2: T.untyped,
          b2: T.untyped,
          c2: T.untyped,
          d2: T.untyped,
          e2: T.untyped,
          f2: T.untyped
        ).returns(T.untyped)
      end
      def faster_multiply!(a2, b2, c2, d2, e2, f2); end
    end

    class UnimplementedSecurityHandler
      sig { params(encrypt: T.untyped).returns(T.untyped) }
      def self.supports?(encrypt); end

      sig { params(buf: T.untyped, ref: T.untyped).returns(T.untyped) }
      def decrypt(buf, ref); end
    end

    class XRef
      include Enumerable

      sig { returns(T.untyped) }
      attr_reader :trailer

      sig { params(io: T.untyped).void }
      def initialize(io); end

      sig { returns(T.untyped) }
      def size; end

      sig { params(ref: T.untyped).returns(T.untyped) }
      def [](ref); end

      sig { params(block: T.untyped).returns(T.untyped) }
      def each(&block); end

      sig { params(offset: T.untyped).returns(T.untyped) }
      def load_offsets(offset = nil); end

      sig { params(buf: T.untyped).returns(T.untyped) }
      def load_xref_table(buf); end

      sig { params(stream: T.untyped).returns(T.untyped) }
      def load_xref_stream(stream); end

      sig { params(bytes: T.untyped).returns(T.untyped) }
      def unpack_bytes(bytes); end

      sig { params(offset: T.untyped).returns(T.untyped) }
      def new_buffer(offset = 0); end

      sig { params(id: T.untyped, gen: T.untyped, offset: T.untyped).returns(T.untyped) }
      def store(id, gen, offset); end

      sig { params(io: T.untyped).returns(T.untyped) }
      def calc_junk_offset(io); end
    end

    class ZeroWidthRunsFilter
      extend T::Sig

      sig { params(runs: T::Array[PDF::Reader::TextRun]).returns(T::Array[PDF::Reader::TextRun]) }
      def self.exclude_zero_width_runs(runs); end
    end

    module Filter
      sig { params(name: T.untyped, options: T.untyped).returns(T.untyped) }
      def self.with(name, options = {}); end

      class Ascii85
        extend T::Sig

        sig { params(options: T.untyped).void }
        def initialize(options = {}); end

        sig { params(data: String).returns(String) }
        def filter(data); end
      end

      class AsciiHex
        extend T::Sig

        sig { params(options: T.untyped).void }
        def initialize(options = {}); end

        sig { params(data: String).returns(String) }
        def filter(data); end
      end

      class Depredict
        extend T::Sig

        sig { params(options: T.untyped).void }
        def initialize(options = {}); end

        sig { params(data: String).returns(String) }
        def filter(data); end

        sig { params(data: T.untyped).returns(T.untyped) }
        def tiff_depredict(data); end

        sig { params(data: T.untyped).returns(T.untyped) }
        def png_depredict(data); end
      end

      class Flate
        extend T::Sig
        ZLIB_AUTO_DETECT_ZLIB_OR_GZIP = 47
        ZLIB_RAW_DEFLATE = -15

        sig { params(options: T.untyped).void }
        def initialize(options = {}); end

        sig { params(data: String).returns(String) }
        def filter(data); end

        sig { params(data: T.untyped).returns(T.untyped) }
        def zlib_inflate(data); end
      end

      class Lzw
        extend T::Sig

        sig { params(options: T.untyped).void }
        def initialize(options = {}); end

        sig { params(data: String).returns(String) }
        def filter(data); end
      end

      class Null
        sig { params(options: T.untyped).void }
        def initialize(options = {}); end

        sig { params(data: T.untyped).returns(T.untyped) }
        def filter(data); end
      end

      class RunLength
        extend T::Sig

        sig { params(options: T.untyped).void }
        def initialize(options = {}); end

        sig { params(data: String).returns(String) }
        def filter(data); end
      end
    end

    module WidthCalculator
      class BuiltIn
        BUILTINS = [
        :Courier, :"Courier-Bold", :"Courier-BoldOblique", :"Courier-Oblique",
        :Helvetica, :"Helvetica-Bold", :"Helvetica-BoldOblique", :"Helvetica-Oblique",
        :Symbol,
        :"Times-Roman", :"Times-Bold", :"Times-BoldItalic", :"Times-Italic",
        :ZapfDingbats
      ]

        sig { params(font: T.untyped).void }
        def initialize(font); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def glyph_width(code_point); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def control_character?(code_point); end

        sig { params(font_name: T.untyped).returns(T.untyped) }
        def extract_basefont(font_name); end
      end

      class Composite
        sig { params(font: T.untyped).void }
        def initialize(font); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def glyph_width(code_point); end
      end

      class TrueType
        sig { params(font: T.untyped).void }
        def initialize(font); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def glyph_width(code_point); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def glyph_width_from_font(code_point); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def glyph_width_from_descriptor(code_point); end
      end

      class TypeOneOrThree
        sig { params(font: T.untyped).void }
        def initialize(font); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def glyph_width(code_point); end
      end

      class TypeZero
        sig { params(font: T.untyped).void }
        def initialize(font); end

        sig { params(code_point: T.untyped).returns(T.untyped) }
        def glyph_width(code_point); end
      end
    end
  end
end