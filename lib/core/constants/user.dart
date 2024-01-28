class UserConstant {
  static String ACTIVE = 'active';
  static String ONBOARD_PENDING = 'onboard_pending';
  static String BANNED = 'banned';
  static String HIDE = 'hide';
  static String DELETED = 'deleted';
  static Map<String, String> TYPE_OTP = {
    ACTIVE: ACTIVE,
    ONBOARD_PENDING: ONBOARD_PENDING,
    BANNED: BANNED,
    HIDE: HIDE,
    DELETED: DELETED,
  };

  static String HIP_HOP = 'HIP_HOP';
  static String POP = 'POP';
  static String K_POP = 'K_POP';
  static String COFFE = 'COFFE';
  static String TIKTOK = 'TIKTOK';
  static String TWITTER = 'TWITTER';
  static Map<String, String> PASSIONS = {
    HIP_HOP: HIP_HOP,
    POP: POP,
    K_POP: K_POP,
    COFFE: COFFE,
    TIKTOK: TIKTOK,
    TWITTER: TWITTER,
  };
  static Map<String, String> PASSION_TITLES = {
    'hip hop': HIP_HOP,
    'pop': POP,
    'k-pop': K_POP,
    'coffe': COFFE,
    'tiktok': TIKTOK,
    'twitter': TWITTER,
  };
  static Map<String, String> TITLES_PASSION = {
    HIP_HOP: 'hip hop',
    POP: 'pop',
    K_POP: 'k-pop',
    COFFE: 'coffe',
    TIKTOK: 'tiktok',
    TWITTER: 'twitter',
  };

  static String MAN = 'MAN';
  static String WOMAN = 'WOMAN';
  static String TRANS = 'TRANS';
  static String TRANS_MAN = 'TRANS_MAN';
  static String TRANS_WOMAN = 'TRANS_WOMAN';
  static String AGENDER = 'AGENDER';
  static String OTHER = 'OTHER';
  static Map<String, String> GENDER_TITLES = {
    'man': MAN,
    'woman': WOMAN,
    'trans': TRANS,
    'trans man': TRANS_MAN,
    'trans woman': TRANS_WOMAN,
    'agender': AGENDER,
    'other': OTHER,
  };
  static Map<String, String> TITLES_GENDER = {
    MAN: 'man',
    WOMAN: 'woman',
    TRANS: 'trans',
    TRANS_MAN: 'trans man',
    TRANS_WOMAN: 'trans woman',
    AGENDER: 'agender',
    OTHER: 'other',
  };

  static String STRAIGHT = 'Straight';
  static String GAY = 'Gay';
  static String LESBIAN = 'Leasbian';
  static String BISEXUAL = 'Bisexual';
  static String ASEXUAL = 'Asexual';
  static Map<String, String> SEXUAL_ORIENTATION = {
    STRAIGHT: 'STRAIGHT',
    GAY: 'GAY',
    LESBIAN: 'LESBIAN',
    BISEXUAL: 'BISEXUAL',
    ASEXUAL: 'ASEXUAL',
  };
  static Map<String, String> ORIENTATION_SEXUAL = {
    'STRAIGHT': STRAIGHT,
    'GAY': GAY,
    'LESBIAN': LESBIAN,
    'BISEXUAL': BISEXUAL,
    'ASEXUAL': ASEXUAL,
  };
  static List<String> SEXUAL_ORIENTATIONS = [
    STRAIGHT,
    GAY,
    LESBIAN,
    BISEXUAL,
    ASEXUAL
  ];

  static List<String> RELATIONSHIP_GOALS = [
    'LONG_TERM_PARTNER',
    'LONG_TERM_OPEN_TO_SHORT',
    'SHORT_TERM_OPEN_TO_LONG',
    'SHORT_TERM_FUN',
    'NEW_FRIEND',
    'STILL_FIGURE_OUT',
  ];
}
