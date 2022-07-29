/// Base Url
const String BASE_URL_DIO = "https://tmba.padc.com.mm";
const String IMAGE_BASE_URL = "http://image.tmdb.org/t/p/w400/";

/// End Point
const String ENDPOINT_POST_REGISTER_WITH_EMAIL = "/api/v1/register";
const String ENDPOINT_POST_LOGIN_WITH_EMAIL = "/api/v1/email-login";
const String ENDPOINT_POST_LOGIN_WITH_FACEBOOK = "/api/v1/facebook-login";
const String ENDPOINT_POST_LOGIN_WITH_GOOGLE = "/api/v1/google-login";
const String ENDPOINT_POST_LOGOUT = "/api/v1/logout";
const String ENDPOINT_GET_CINEMA_LIST = "/api/v1/cinemas";
const String ENDPOINT_GET_MOVIE_LIST = "/api/v1/movies";
const String ENDPOINT_GET_MOVIE_DETAILS = "/api/v1/movies";
const String ENDPOINT_GET_SNACK_LIST = "/api/v1/snacks";
const String ENDPOINT_GET_PROFILE = "/api/v1/profile";
const String ENDPOINT_GET_USER_TRANSACTION = "/api/v1/profile/transactions";
const String ENDPOINT_GET_PAYMENT_METHOD_LIST = "/api/v1/payment-methods";
const String ENDPOINT_GET_CINEMA_SEATING_PLAN = "/api/v1/seat-plan";
const String ENDPOINT_GET_CINEMA_DAY_TIMESLOT = "/api/v1/cinema-day-timeslots";
const String ENDPOINT_POST_CREATE_CARD = "/api/v1/card";
const String ENDPOINT_POST_CHECKOUT = "/api/v1/checkout";

/// Parameters
const String HEADER_ACCEPT = "Accept";
const String PARAM_REGISTER_NAME = "name";
const String PARAM_REGISTER_EMAIL = "email";
const String PARAM_REGISTER_PHONE = "phone";
const String PARAM_REGISTER_PASSWORD = "password";
const String PARAM_REGISTER_GOOGLE_ACCESS_TOKEN = "google-access-token";
const String PARAM_REGISTER_FACEBOOK_ACCESS_TOKEN = "facebook-access-token";
const String PARAM_MOVIE_STATUS = "status";
const String HEADER_AUTHORIZATION = "Authorization";
const String PARAM_DATE = "date";
const String PARAM_CINEMA_DAY_TIMESLOTS_ID = "cinema_day_timeslot_id";
const String PARAM_BOOKING_DATE = "booking_date";
const String PARAM_CARD_NUMBER = "card_number";
const String PARAM_CARD_HOLDER = "card_holder";
const String PARAM_EXPIRATION_DATE = "expiration_date";
const String PARAM_CVC = "cvc";
const String PARAM_ACCESS_TOKEN = "access-token";

const String ACCEPT = "application/json";

const int RESPONSE_CODE_SUCCESS = 200;
