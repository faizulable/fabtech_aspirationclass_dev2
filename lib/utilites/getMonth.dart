
String convertNumtoMonth(String monthNumber){
  String returnValue = '';
  switch(monthNumber){
    case "01": {
      returnValue = 'JANUARY';
      break;
    }
    case "02": {
      returnValue = 'FEBRUARY';
      break;
    }
    case "03": {
      returnValue = 'MARCH';
      break;
    }
    case "04": {
      returnValue = 'APRIL';
      break;
    }
    case "05": {
      returnValue = 'MAY';
      break;
    }
    case "06": {
      returnValue = 'JUNE';
      break;
    }
    case "07": {
      returnValue = 'JULY';
      break;
    }
    case "08": {
      returnValue = 'AUGUST';
      break;
    }
    case "09": {
      returnValue = 'SEPTEMBER';
      break;
    }
    case "10": {
      returnValue = 'OCTOBER';
      break;
    }
    case "11": {
      returnValue = 'NOVEMBER';
      break;
    }
    case "12": {
      returnValue = 'DECEMBER';
      break;
    }
    default: {
      returnValue = 'MISCELLANEOUS';
      break;
    }
  }

  return returnValue;
}