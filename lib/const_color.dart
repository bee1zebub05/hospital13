import "package:another_flushbar/flushbar.dart";
import 'package:beginapp01/OOP_material/appoinment.dart';
import "package:beginapp01/OOP_material/doctor.dart";
import "package:beginapp01/OOP_material/patient.dart";
import "package:beginapp01/OOP_material/person.dart";
import "package:flutter/material.dart";

//MAP LƯU CÁC TỪ KHÓA TƯƠNG ỨNG VỚI CÁC KHOA
Map<String, List<String>> specialityKeyWord = {
  'Tai mũi họng' : ["viêm họng", "đau cổ", "viêm amidan", "viêm tai giữa", "nghẹt mũi", "xoang", "viêm mũi dị ứng", "chảy máu cam", "điếc đột ngột", "ù tai", "rối loạn giọng nói", "khó thở", "sỏi amidan", "nhiễm trùng tai ngoài", "viêm thanh quản", "viêm mũi", "cảm lạnh", "dị ứng", "nhiễm trùng tai trong", "khối u mũi", "rối loạn thính giác", "nhiễm trùng xoang", "viêm tai ngoài", "tắc nghẽn mũi", "chảy nước mũi", "họng khô", "khó nuốt", "cơn ho", "chảy mủ tai", "mất thính giác", "chóng mặt", "vẹo vách ngăn mũi", "viêm mũi mạn tính", "khối u cổ", "hôi miệng", "viêm thanh quản mãn tính", "viêm họng mạn tính", "cổ họng sưng tấy", "cảm cúm", "hội chứng ngừng thở khi ngủ", "viêm dây thanh âm", "nổi hạch cổ", "vỡ mạch máu tai", "khó thở khi ngủ", "rối loạn nuốt", "mắt đỏ", "hóc xương", "viêm tắc tuyến lệ", "chứng nghẹt mũi mùa xuân", "nhiễm trùng miệng", "tắc ống tai", "viêm mũi vách ngăn", "viêm cổ họng hạt", "chứng dị ứng môi", "chứng ngứa tai", "viêm tai trong", "thường xuyên đau đầu", "tổn thương dây thanh âm", "khó thở khi nói", "sưng cổ họng", "chảy nước mắt", "hỏng giọng", "viêm mũi teo", "khó thở khi vận động", "viêm họng cấp tính", "dịch tai", "phồng tai", "tai bị chảy máu", "thở khò khè", "nổi u cổ", "khó ngủ", "cảm giác ngứa trong cổ họng", "bệnh lý tai trong", "viêm amidan hốc mủ", "viêm họng đỏ", "viêm họng do virus", "bệnh viêm tai mũi họng", "nhiễm khuẩn mũi", "đau tai", "chảy mủ mũi", "viêm tai trong do virus", "khó nói", "môi khô", "chứng ngủ ngáy", "sưng tai", "bệnh lý mũi", "viêm nướu miệng", "lệch vách ngăn mũi", "viêm hạch cổ", "chứng ù tai", "giảm thính lực", "viêm tuyến nước bọt", "chứng nghẹt mũi vĩnh viễn", "tổn thương tai do tiếng ồn", "viêm vòm họng", "chảy nước miếng", "cổ họng khó chịu", "đau vùng tai", "viêm tai mũi họng cấp tính", "giảm khả năng nuốt", "khó thở khi ăn", "viêm loét vòm họng", "lở miệng", "viêm mũi do vi khuẩn", "chảy mủ tai mũi", "ngứa cổ họng", "dị ứng với thức ăn", "viêm nướu răng", "mất vị giác", "chứng đau đầu liên quan tai mũi họng", "cổ họng tấy đỏ", "mụn nhọt tai", "hơi thở nặng", "mụn trong tai"],


  'Răng hàm mặt': ["sâu răng", "viêm nướu", "viêm lợi", "hôi miệng", "viêm nha chu", "viêm tủy răng", "viêm miệng", "sâu răng cửa", 
 "viêm răng miệng", "tẩy trắng răng", "răng mọc lệch", "viêm tủy cấp tính", "bệnh lý răng miệng", "răng khôn", 
 "viêm chân răng", "chấn thương răng", "viêm lợi cấp tính", "tình trạng hôi miệng", "bệnh viêm miệng", "sâu răng hàm", 
 "răng bị mẻ", "bệnh nha chu", "viêm tủy răng mãn tính", "nhiễm trùng răng miệng", "nhiễm trùng lợi", "nhiễm trùng chân răng", 
 "răng sữa bị sâu", "răng giả bị lỏng", "răng bị vỡ", "bệnh viêm nướu", "bệnh răng miệng trẻ em", "viêm miệng do vi khuẩn", 
 "mảng bám răng", "viêm nướu mãn tính", "rối loạn khớp cắn", "viêm loét miệng", "bệnh tủy răng", "răng ố vàng", 
 "bệnh lý răng trẻ em", "cắn lưỡi", "bệnh sâu răng", "viêm họng do răng", "viêm họng mủ", "lở miệng", "viêm chân răng cấp tính", 
 "răng lệch lạc", "răng bị ê buốt", "sâu răng hàm dưới", "bệnh lý tủy răng", "rối loạn miệng", "chảy máu chân răng", 
 "viêm tủy răng cấp", "tê răng", "bệnh nhiễm trùng miệng", "viêm amidan", "tổn thương mô nướu", "nhiễm trùng vùng miệng", 
 "tủy răng chết", "cắn răng không đều", "tổn thương răng miệng", "viêm tủy mãn tính", "các vấn đề về nướu", "răng bị vỡ", 
 "viêm miệng dạng loét", "tình trạng nướu bị sưng", "chấn thương răng miệng", "bệnh viêm nướu", "rối loạn khớp cắn", 
 "mất răng", "bệnh lý răng miệng mãn tính", "bệnh lý nha chu mãn tính", "lở loét miệng", "mất răng hàm", 
 "nhiễm trùng tủy răng", "bệnh lý răng miệng do vi khuẩn", "răng cửa bị sâu", "viêm loét miệng", "viêm tủy răng nghiêm trọng", 
 "bệnh viêm răng miệng", "rối loạn tủy răng", "viêm mô nướu", "tình trạng răng mọc lệch", "bệnh sâu răng mãn tính", 
 "chấn thương tủy răng", "viêm mô mềm miệng", "răng bị sưng", "răng bị sưng tấy", "bệnh lý viêm chân răng", 
 "viêm răng miệng do vi khuẩn", "bệnh nha chu cấp tính", "bệnh viêm mô lợi", "viêm miệng do virus", 
 "sâu răng ở trẻ em", "nhiễm trùng răng miệng ở người lớn", "viêm lợi mãn tính", "tình trạng răng miệng nhiễm khuẩn"],

  'Cơ xương khớp': ["thoái hóa khớp", "viêm khớp", "gai cột sống", "viêm khớp dạng thấp", "đau lưng", "đau cổ", "thoái hóa đốt sống cổ", 
"viêm gân", "viêm cơ", "thoái hóa khớp gối", "viêm khớp vảy nến", "đau nhức xương khớp", "lỏng khớp", "xương bị gãy", 
"viêm cột sống dính khớp", "bệnh gout", "đau cơ", "hội chứng ống cổ tay", "viêm khớp nhiễm khuẩn", "đau lưng dưới", 
"đau vai gáy", "đau khớp gối", "bệnh lý khớp", "gãy xương", "đau mỏi cơ", "bệnh viêm xương", "bệnh loãng xương", 
"chấn thương khớp", "viêm bao hoạt dịch", "bệnh thoái hóa xương khớp", "gãy cổ tay", "bệnh lý cơ xương khớp", 
"viêm cơ cánh tay", "xơ cứng cơ", "viêm khớp sưng tấy", "viêm đĩa đệm", "bệnh cột sống", "lệch khớp", "đau thần kinh tọa", 
"viêm khớp mãn tính", "đau nhức cơ xương", "bệnh xương khớp tuổi già", "đau xương sườn", "bệnh khớp gối", 
"bệnh đĩa đệm", "đau thần kinh", "bệnh viêm cơ", "bệnh lý đĩa đệm", "gãy xương đùi", "đau khớp vai", "viêm khớp gối", 
"đau khớp cổ tay", "đau khớp hông", "viêm khớp nặng", "chấn thương đĩa đệm", "viêm cơ bắp", "bệnh loãng xương sau mãn kinh", 
"gãy xương cẳng tay", "bệnh viêm khớp sưng", "bệnh viêm bao hoạt dịch", "đau nhức vai", "đau khớp ngón tay", 
"đau nhức lưng", "viêm khớp gối nặng", "thoái hóa đĩa đệm", "viêm khớp mạn tính", "bệnh rối loạn cơ xương khớp", 
"bệnh viêm cột sống", "gãy xương cánh tay", "bệnh khớp sụn", "bệnh lý khớp vai", "viêm khớp tay", "viêm khớp cổ", 
"gãy xương gót chân", "cứng khớp", "bệnh viêm đĩa đệm", "đau khớp ngón chân", "chấn thương cơ bắp", "gãy xương chậu", 
"bệnh cơ xương khớp mãn tính", "bệnh lý viêm khớp", "viêm cột sống", "bệnh đau khớp", "đau khớp chân", "gai khớp", 
"viêm khớp cấp tính", "chấn thương cổ tay", "viêm cơ cổ", "gãy xương cột sống", "bệnh cơ bắp mãn tính", "đau cơ xương", 
"thoái hóa xương", "bệnh lý xương khớp", "viêm khớp mạn tính", "gãy xương xương chậu", "thoái hóa đốt sống", 
"viêm gân Achilles", "chấn thương cơ khớp", "cứng cơ", "viêm khớp ngón tay", "viêm bao hoạt dịch khớp vai", 
"bệnh cứng khớp", "đau cơ cổ", "bệnh xương khớp mạn tính", "đau nhức khớp vai", "viêm cơ mông", "đau khớp hông", 
"thoái hóa khớp cổ tay", "viêm khớp ngón chân", "bệnh gout cấp", "đau thắt lưng", "bệnh xương thoái hóa", "đau xương cẳng tay", 
"viêm xương khớp mãn tính", "viêm cơ chân", "viêm khớp dạng thấp ở người cao tuổi", "gãy xương đốt sống", 
"viêm khớp dạng thấp cấp tính", "đau khớp cổ", "chấn thương cột sống", "đau cột sống cổ", "bệnh viêm cơ cánh tay"],

  'Mắt' : ["cận thị", "viễn thị", "loạn thị", "lão thị", "đục thủy tinh thể", "glaucoma", "tăng nhãn áp", "thoái hóa điểm vàng", 
"mù màu", "chảy nước mắt", "cườm mắt", "bệnh võng mạc", "viêm kết mạc", "viêm mí mắt", "viêm giác mạc", "bệnh lý võng mạc", 
"viêm mống mắt", "cải thiện thị lực", "rối loạn thị lực", "mỏi mắt", "quáng gà", "khô mắt", "viêm đáy mắt", 
"bệnh võng mạc tiểu đường", "đau mắt", "rối loạn điều tiết", "thị lực giảm", "nhìn mờ", "thị lực kém", "cứng mí mắt", 
"nhìn hai", "tật khúc xạ", "viêm giác mạc nhiễm khuẩn", "giảm thị lực", "cườm mắt do tuổi tác", "mắt bị khô", 
"viêm kết mạc dị ứng", "đau mắt đỏ", "đục thủy tinh thể do tuổi tác", "dị ứng mắt", "sốt mắt", "lác mắt", 
"lác mắt trẻ em", "viêm kết mạc do vi khuẩn", "rối loạn mống mắt", "tổn thương võng mạc", "viêm mống mắt cấp", 
"viêm mắt do virus", "bệnh lý mắt tiểu đường", "đau mắt do viêm", "tổn thương giác mạc", "sốc mắt", "đục thủy tinh thể do bệnh lý", 
"thoái hóa mắt", "chảy máu mắt", "mù lòa", "mù mắt", "nhiễm trùng mắt", "viêm mắt do vi khuẩn", "mắt sưng", 
"thị lực yếu", "bệnh mắt do cận thị", "viêm quỹ đạo mắt", "viêm màng bồ đào", "mắt bị tổn thương", "mỏi mắt khi nhìn gần", 
"mờ mắt", "mất thị lực", "rối loạn quỹ đạo mắt", "dị ứng kết mạc", "lão hóa mắt", "rối loạn hình ảnh", 
"khô mắt do máy lạnh", "thị lực giảm dần", "mất cảm giác mắt", "lác mắt sau phẫu thuật", "điều trị mắt mờ", 
"chảy nước mắt liên tục", "mắt lác", "mắt đỏ", "bệnh lý giác mạc", "nhiễm trùng mắt", "viêm kết mạc cấp tính", 
"cận thị nặng", "các bệnh lý võng mạc", "bệnh mắt tiểu đường", "lác mắt tạm thời", "tổn thương võng mạc do tuổi tác", 
"chứng lác mắt", "viêm mi mắt", "rối loạn mắt", "chảy máu mống mắt", "đau mắt khi nhìn", "suy giảm thị lực", 
"bệnh lý mắt liên quan đến tiểu đường", "rối loạn thị lực do tuổi tác", "mắt không mở", "dị ứng với ánh sáng", 
"rối loạn thị giác", "tổn thương mô mắt", "bệnh mắt do thuốc", "chấn thương mắt", "đau mắt khi thức dậy", 
"viêm mống mắt", "bệnh lý võng mạc tiểu đường", "mắt nhạy cảm", "mắt bị cứng", "cải thiện thị lực cho người cao tuổi", 
"cải thiện thị lực tạm thời", "mỏi mắt do máy tính", "mắt khó chịu", "nhìn mờ khi lái xe", "cảm giác cộm trong mắt"],

  'Da liễu' : ["mụn trứng cá", "viêm da", "eczema", "vẩy nến", "viêm da tiếp xúc", "mụn nhọt", "mụn đầu đen", "mụn mủ", "rạn da", 
"chàm", "vết thương hở", "mẩn ngứa", "nấm da", "nám da", "sạm da", "lão hóa da", "viêm da cơ địa", "bệnh vẩy nến", 
"mụn cám", "bệnh lý da liễu", "mụn đỏ", "da khô", "bệnh ngoài da", "mụn đầu trắng", "bệnh da liễu", "viêm da mủ", 
"vảy nến da đầu", "dày sừng da", "mụn bọc", "hắc lào", "bệnh vẩy nến da đầu", "sẩn ngứa", "bệnh vảy nến mãn tính", 
"nấm móng", "nấm tóc", "mụn trứng cá bọc", "nấm da đầu", "vảy nến ở tay", "tàn nhang", "chàm eczema", "viêm da sần sùi", 
"mụn bọc ở lưng", "mụn mủ trên mặt", "nám mảng", "mụn ở lưng", "mụn ở ngực", "mụn ở cánh tay", "tóc gãy", 
"rạn da bụng", "da bị tổn thương", "viêm da do dị ứng", "nổi mẩn đỏ", "bệnh da liễu do nhiễm khuẩn", "da bị dị ứng", 
"bệnh da liễu tuổi già", "viêm da do vi khuẩn", "da bị ngứa", "chàm da", "lỗ chân lông to", "viêm da mãn tính", 
"bệnh da mẩn ngứa", "mụn trứng cá do hormone", "tình trạng da mẩn đỏ", "nám da mặt", "mụn ở mặt", "mụn đầu đen ở mũi", 
"rạn da sau sinh", "da mặt khô", "chàm bội nhiễm", "nấm da chân", "mụn nhọt do vi khuẩn", "mụn đỏ ở mặt", "mụn lưng", 
"viêm da đầu", "da nhờn", "mụn do stress", "sạm màu da", "viêm da mặt", "mụn trứng cá bọc ở mặt", "mụn cám ở mũi", 
"mụn trứng cá sau sinh", "viêm da do nấm", "tóc gãy rụng", "lớp biểu bì da", "bệnh ngoài da do vi khuẩn", 
"da bị dị ứng thời tiết", "mụn viêm", "viêm da ở trẻ em", "da không đều màu", "bệnh vảy nến ở trẻ em", 
"tình trạng da mặt mẩn đỏ", "vết sẹo thâm do mụn", "da bị mụn trứng cá", "nám da do thai kỳ", "mùi cơ thể", 
"viêm da nấm", "viêm da chân tay", "màng da", "nốt ruồi", "sắc tố da", "mụn trứng cá do chế độ ăn uống", 
"nám mảng trên mặt", "viêm da do hóa chất", "mụn trứng cá do vi khuẩn", "nấm da ở bàn tay", "mẩn ngứa da", 
"viêm da đầu do nấm", "mụn nhọt do dị ứng", "da bị kích ứng", "bệnh chàm da", "mụn trứng cá ở lưng", 
"tình trạng da mặt khô", "viêm nang lông", "da mẩn đỏ", "mụn do thay đổi thời tiết", "bệnh nấm da đầu", 
"viêm da tay chân", "viêm da tiếp xúc dị ứng", "mụn do thiếu ngủ", "rối loạn sắc tố da", "da mặt bị mụn", 
"mẩn ngứa da do dị ứng", "tổn thương da", "viêm da do vi khuẩn dị ứng", "da bị nhờn", "da bị cháy nắng", 
"viêm da dị ứng", "mụn do thay đổi nội tiết", "tình trạng da mặt mịn", "mụn do sử dụng mỹ phẩm", "mụn cám ở cằm"],

  'Thần kinh' : ["đột quỵ", "tai biến mạch máu não", "parkinson", "alzheimer", "chóng mặt", "đau đầu", "migraine", "bệnh thần kinh", 
"rối loạn thần kinh", "co giật", "đau nửa đầu", "tổn thương thần kinh", "bệnh lý thần kinh ngoại biên", "rối loạn cảm giác", 
"tê tay chân", "yếu tay chân", "bệnh thần kinh tự chủ", "bệnh đa xơ cứng", "đau thần kinh tọa", "bệnh động kinh", 
"rối loạn thần kinh thực vật", "rối loạn tâm thần", "hội chứng Guillain-Barré", "viêm màng não", "bệnh thần kinh trung ương", 
"rối loạn giấc ngủ", "bệnh thần kinh tiểu đường", "bệnh não", "co giật do sốt", "rối loạn vận động", "bệnh Huntington", 
"tổn thương tủy sống", "bệnh lý động mạch não", "hội chứng chân không yên", "đau lưng do thần kinh", "bệnh thần kinh ngoại biên", 
"tê bì tay chân", "bệnh lý thần kinh trung ương", "mất trí nhớ", "bệnh mất trí nhớ", "rối loạn nhận thức", "bệnh thần kinh do virus", 
"liệt mặt", "bệnh thần kinh mạch máu", "viêm thần kinh", "hội chứng Tourette", "đau đầu migraine", "bệnh thần kinh liên quan đến tim", 
"bệnh lý thần kinh chức năng", "rối loạn thần kinh tiểu não", "đau đầu căng cơ", "rối loạn thần kinh cảm giác", "bệnh thần kinh tiểu đường", 
"co thắt cơ", "dáng đi bất thường", "rối loạn điều phối vận động", "đau thần kinh sau zona", "rối loạn vận động mắt", "tổn thương dây thần kinh", 
"chứng bệnh Parkinson", "hội chứng ngừng thở khi ngủ", "rối loạn thần kinh mãn tính", "rối loạn khí quản", "bệnh thần kinh não bộ", 
"đau đầu liên tục", "rối loạn tâm thần", "bệnh lý thần kinh tiểu não", "bệnh lý tủy sống", "hội chứng mất trí", "rối loạn tâm trạng", 
"viêm đa dây thần kinh", "tổn thương thần kinh ngoại biên", "mất thăng bằng", "cảm giác không đều", "tổn thương não bộ", "đau thần kinh", 
"chứng mất trí nhớ", "bệnh lyme", "dễ cáu gắt", "rối loạn vận động cơ", "viêm dây thần kinh", "chứng động kinh", "bệnh lý thần kinh gây liệt", 
"chấn thương tủy sống", "liệt nửa người", "bệnh rối loạn thần kinh tự chủ", "hội chứng lệch cơ", "tổn thương thần kinh thực vật", 
"cảm giác tay chân tê liệt", "chứng tê liệt", "đau thần kinh liên quan đến tim", "bệnh thần kinh tiểu đường", "rối loạn thần kinh mạn tính", 
"bệnh đa xơ cứng", "tổn thương tế bào thần kinh", "co giật do động kinh", "bệnh động kinh không kiểm soát", "chứng mất trí nhớ do bệnh lý", 
"đột quỵ nhẹ", "hội chứng lệch não", "rối loạn thần kinh tủy sống", "viêm não", "liệt mặt do thần kinh", "suy giảm nhận thức", 
"chứng rối loạn thần kinh tự chủ", "chứng đau thần kinh", "tổn thương thần kinh do tai nạn", "chứng bệnh tâm thần", "liệt vận động", 
"đau cơ do thần kinh", "hội chứng đau thần kinh", "viêm tủy sống", "đau do thần kinh bị chèn ép", "rối loạn vận động vô thức", 
"bệnh lý thần kinh thoái hóa", "hội chứng tê tay chân", "tổn thương não bộ do chấn thương", "bệnh thần kinh do nhiễm trùng", 
"chứng rối loạn thần kinh cảm giác", "bệnh thần kinh liên quan đến lão hóa", "rối loạn não bộ", "bệnh thần kinh do mạch máu", 
"tổn thương thần kinh chức năng", "chứng bệnh thần kinh cột sống", "rối loạn thần kinh do lạm dụng thuốc", "viêm thần kinh ngoại biên"],

  'Tim mạch' : ["tăng huyết áp", "huyết áp cao", "huyết áp thấp", "đau thắt ngực", "nhồi máu cơ tim", "suy tim", "rối loạn nhịp tim", 
"loạn nhịp tim", "xơ vữa động mạch", "bệnh mạch vành", "suy tim trái", "suy tim phải", "bệnh tim bẩm sinh", "hẹp van tim", 
"bệnh tim thiếu máu", "tắc nghẽn mạch máu", "viêm cơ tim", "bệnh tim mạch", "hẹp động mạch vành", "bệnh động mạch ngoại biên", 
"thiếu máu cơ tim", "đột quỵ tim", "cơn đau thắt ngực", "bệnh van tim", "suy tim nặng", "mảng xơ vữa động mạch", "nhịp tim không đều", 
"nhồi máu não", "huyết áp cao do stress", "huyết áp thấp tư thế", "tăng huyết áp mạn tính", "bệnh lý mạch máu", "suy tim cấp", 
"cơn đau thắt ngực không ổn định", "hẹp động mạch chủ", "đau tim", "viêm động mạch", "tắc nghẽn động mạch", "mạch máu bị hẹp", 
"bệnh mạch máu não", "tăng huyết áp nặng", "nhịp tim nhanh", "nhịp tim chậm", "rối loạn nhịp tim nhanh", "hẹp động mạch cảnh", 
"nhồi máu cơ tim cấp", "tắc mạch phổi", "tăng lipid máu", "hội chứng mạch vành cấp", "bệnh mạch máu ngoại vi", "mạch máu bị tắc", 
"bệnh động mạch não", "cơn đau ngực", "rối loạn nhịp tim xoang", "tắc nghẽn mạch vành", "mảng vữa xơ động mạch", "huyết áp không ổn định", 
"viêm mạch máu", "rối loạn huyết áp", "chứng nhồi máu cơ tim", "suy tim mạn tính", "bệnh mạch vành mãn tính", "đột quỵ do tim", 
"cơn nhồi máu cơ tim", "huyết áp cao ở người già", "tăng huyết áp do thận", "bệnh động mạch chủ", "bệnh lý van tim", "rối loạn huyết áp", 
"rối loạn tuần hoàn não", "mạch vành bị hẹp", "bệnh tim mạch do tiểu đường", "huyết áp thấp đột ngột", "đau tim do thiếu máu", 
"viêm màng ngoài tim", "tắc nghẽn mạch máu phổi", "bệnh lý tim mạch mãn tính", "huyết áp thấp sau ăn", "hẹp van động mạch chủ", 
"hội chứng mạch máu não", "bệnh lý tim mạch do nhiễm trùng", "huyết áp cao do bệnh thận", "tim mạch ngoại biên", "hẹp van hai lá", 
"cơn thắt ngực do mạch vành", "huyết áp thấp do thuốc", "bệnh tim mạch không triệu chứng", "tăng huyết áp do thuốc", "tắc mạch não", 
"nhồi máu cơ tim do tắc nghẽn", "cơn đau thắt ngực ổn định", "đau thắt ngực không ổn định", "hẹp động mạch phổi", "huyết áp cao và tiểu đường", 
"bệnh tim mạch do rối loạn lipid máu", "rối loạn mạch vành", "bệnh mạch máu đầu chi", "bệnh tim mạch do hút thuốc", "đau tim do viêm", 
"huyết áp cao do béo phì", "huyết áp thấp do giảm thể tích máu", "bệnh mạch vành cấp", "huyết áp tăng sau khi ăn", "cơn đau ngực đột ngột", 
"rối loạn tuần hoàn động mạch", "rối loạn tuần hoàn mạch máu", "bệnh lý mạch máu não", "rối loạn nhịp tim do thiếu máu cơ tim", 
"chứng thiếu máu cơ tim", "cơn đau tim do bệnh lý động mạch vành", "suy tim cấp tính", "rối loạn mạch vành", "huyết áp tăng đột ngột", 
"bệnh lý tim mạch do di truyền", "suy tim do bệnh lý van tim", "hội chứng mạch máu tiểu não"],

  'Ung bứu' : ["ung thư", "ung thư vú", "ung thư phổi", "ung thư dạ dày", "ung thư gan", "ung thư đại trực tràng", "ung thư máu", 
"ung thư tuyến tiền liệt", "ung thư da", "ung thư bạch cầu", "ung thư hạch", "ung thư vòm họng", "ung thư cổ tử cung", 
"ung thư buồng trứng", "ung thư thanh quản", "ung thư não", "ung thư tuyến giáp", "ung thư thận", "ung thư thực quản", 
"ung thư miệng", "ung thư phế quản", "ung thư hạ họng", "ung thư ruột", "ung thư tinh hoàn", "ung thư bàng quang", 
"ung thư tủy xương", "ung thư gan mật", "ung thư mô mềm", "ung thư tụy", "ung thư vùng kín", "ung thư não bộ", 
"ung thư vú giai đoạn cuối", "ung thư giai đoạn đầu", "ung thư phổi không tế bào nhỏ", "ung thư phổi tế bào nhỏ", 
"ung thư hạch bạch huyết", "ung thư đại trực tràng giai đoạn cuối", "ung thư buồng trứng di căn", "ung thư dạ dày di căn", 
"ung thư cổ tử cung di căn", "ung thư thận giai đoạn cuối", "ung thư tuyến giáp di căn", "ung thư dạ dày giai đoạn cuối", 
"ung thư vú giai đoạn đầu", "ung thư dạ dày giai đoạn đầu", "ung thư đại tràng giai đoạn đầu", "ung thư hạch bạch huyết giai đoạn cuối", 
"ung thư tuyến tiền liệt giai đoạn cuối", "ung thư phổi di căn", "ung thư gan di căn", "ung thư vú di căn", "ung thư phổi giai đoạn cuối", 
"ung thư thận di căn", "ung thư máu giai đoạn cuối", "ung thư buồng trứng giai đoạn cuối", "ung thư thanh quản giai đoạn đầu", 
"ung thư vòm họng giai đoạn cuối", "ung thư tuyến tiền liệt di căn", "ung thư gan giai đoạn cuối", "ung thư đại tràng di căn", 
"ung thư máu giai đoạn đầu", "ung thư phổi giai đoạn đầu", "ung thư dạ dày di căn", "ung thư vú di căn", "ung thư miệng giai đoạn đầu", 
"ung thư vùng kín giai đoạn cuối", "ung thư hạch bạch huyết di căn", "ung thư não bộ giai đoạn đầu", "ung thư tụy giai đoạn đầu", 
"ung thư tuyến giáp giai đoạn đầu", "ung thư ruột giai đoạn đầu", "ung thư tuyến tiền liệt giai đoạn đầu", "ung thư bàng quang giai đoạn đầu", 
"ung thư tụy di căn", "ung thư tế bào gan", "ung thư tủy xương giai đoạn cuối", "ung thư tế bào phổi", "ung thư thận tế bào vỏ", 
"ung thư mũi", "ung thư trực tràng", "ung thư amidan", "ung thư thực quản di căn", "ung thư tuyến thượng thận", "ung thư niêm mạc tử cung", 
"ung thư tuyến yên", "ung thư da không di căn", "ung thư da di căn", "ung thư ruột già", "ung thư bạch cầu cấp", "ung thư dạ dày giai đoạn đầu", 
"ung thư vú tế bào vảy", "ung thư mỡ", "ung thư kết hợp xạ trị", "ung thư buồng trứng tế bào sáng", "ung thư trực tràng giai đoạn đầu", 
"ung thư biểu mô tuyến", "ung thư tủy sống", "ung thư khoang miệng", "ung thư buồng trứng", "ung thư thượng thận", "ung thư tuyến mồ hôi", 
"ung thư phổi tế bào nhỏ", "ung thư miệng giai đoạn cuối", "ung thư mô đệm", "ung thư đại trực tràng tế bào", "ung thư đầu cổ", 
"ung thư mô mềm giai đoạn đầu", "ung thư gan mật", "ung thư vú tế bào", "ung thư cổ tử cung giai đoạn đầu", "ung thư thận tế bào", 
"ung thư ruột kết", "ung thư xương", "ung thư di căn hạch", "ung thư gan tế bào", "ung thư tế bào hắc tố", "ung thư sinh dục nữ", 
"ung thư phổi mô đệm", "ung thư máu mãn tính", "ung thư máu cấp tính", "ung thư hạch bạch huyết giai đoạn đầu"],

  'Cấp cứu' : ["chấn thương", "tai nạn giao thông", "ngộ độc", "đột quỵ", "đau ngực cấp", "ngừng tim", "suy hô hấp cấp", 
"chảy máu cấp", "sốc", "hạ huyết áp cấp", "tăng huyết áp cấp", "cơn đau thắt ngực cấp", "cấp cứu tim mạch", "đột quỵ não", 
"tổn thương đầu", "cơn co giật", "huyết áp thấp đột ngột", "hội chứng mạch vành cấp", "cấp cứu nhiễm trùng", 
"ngộ độc thực phẩm", "ngộ độc thuốc", "sốc phản vệ", "chấn thương sọ não", "đau bụng cấp", "ho ra máu", "ngạt thở", 
"viêm phổi cấp", "nhồi máu cơ tim cấp", "tai nạn lao động", "suy thận cấp", "tổn thương bỏng", "tổn thương cột sống", 
"tổn thương động mạch", "chấn thương ngực", "chấn thương bụng", "đột quỵ cấp", "cơn nhồi máu cơ tim", "nhiễm trùng cấp", 
"ho khan", "mất nước cấp", "suy tim cấp", "nghẹt thở", "hội chứng tràn dịch màng phổi", "hội chứng động mạch vành cấp", 
"tai nạn ngã", "trúng gió", "bệnh tim mạch cấp", "tổn thương mắt cấp", "sốc nhiệt", "rối loạn nhịp tim cấp", 
"viêm ruột cấp", "chảy máu dạ dày cấp", "chảy máu não", "bệnh tắc nghẽn mạch phổi", "suy gan cấp", "viêm màng não cấp", 
"bỏng cấp", "viêm thận cấp", "cấp cứu thần kinh", "viêm gan cấp", "nhiễm trùng đường hô hấp cấp", "suy hô hấp cấp do viêm phổi", 
"tổn thương động mạch chủ", "chấn thương cánh tay", "cơn thắt ngực", "rối loạn đông máu cấp", "ngộ độc khí", 
"tổn thương xương khớp", "cấp cứu sản khoa", "chấn thương vùng kín", "suy tuần hoàn cấp", "viêm dạ dày cấp", 
"ho máu", "ngừng hô hấp", "tai nạn điện giật", "trẻ em ngộ độc", "cấp cứu chấn thương sọ não", "hạ đường huyết cấp", 
"đột quỵ thiếu máu não", "viêm phổi do vi khuẩn", "tổn thương thần kinh cấp", "chấn thương vùng đầu mặt cổ", 
"tổn thương mắt do hoá chất", "rối loạn nhịp tim do thiếu máu cơ tim", "nhiễm trùng huyết", "tổn thương mạch máu", 
"đau bụng cấp tính", "ngạt khí", "ngộ độc thuốc lá", "viêm ruột thừa cấp", "viêm túi mật cấp", "tổn thương phổi cấp", 
"rối loạn nhịp tim nhanh", "rối loạn thở", "tổn thương da cấp", "suy hô hấp do viêm phổi", "cơn động kinh cấp", 
"cảm lạnh cấp", "ho sốt cấp", "ho kéo dài", "cơn đau bụng cấp", "tổn thương tim cấp", "ngạt thở cấp", "suy tim cấp tính", 
"tăng huyết áp cấp tính", "tràn khí màng phổi cấp", "viêm đường tiết niệu cấp", "ngộ độc rượu", "nhiễm khuẩn cấp", 
"bệnh lý tim mạch cấp", "tổn thương tai", "hoại tử cơ tim", "tổn thương phổi cấp tính", "chấn thương phần mềm", "suy thận cấp tính", 
"chảy máu âm đạo", "bệnh lý gan cấp", "sốc tim", "suy gan cấp tính", "viêm khớp cấp", "viêm thận cấp tính", "bệnh tim cấp cứu"],

  'Sản': ["mang thai", "sảy thai", "thai ngoài tử cung", "mất thai", "sinh non", "đau bụng dưới", "vỡ ối", "chảy máu âm đạo", 
"tiền sản giật", "sản giật", "hội chứng tiền sản giật", "băng huyết sau sinh", "đái tháo đường thai kỳ", "nhiễm trùng thai kỳ", 
"chửa trứng", "đau khi sinh", "dọa sảy thai", "dọa sinh non", "suy thai", "thai chết lưu", "thai kỳ có nguy cơ cao", 
"viêm âm đạo", "viêm tử cung", "viêm phần phụ", "u xơ tử cung", "u nang buồng trứng", "bệnh lý cổ tử cung", "polyp cổ tử cung", 
"viêm nhiễm âm đạo", "nhiễm khuẩn đường tiết niệu thai kỳ", "đau lưng khi mang thai", "rối loạn tiêu hóa thai kỳ", 
"thai kỳ ngoài tử cung", "sản phụ khoa", "phẫu thuật cắt tử cung", "phẫu thuật cắt buồng trứng", "vỡ tử cung", 
"hoại tử tử cung", "bệnh lý tuyến vú", "cảm cúm thai kỳ", "lạc nội mạc tử cung", "hội chứng buồng trứng đa nang", 
"bệnh tim mạch thai kỳ", "tăng huyết áp thai kỳ", "nhiễm trùng sau sinh", "chảy máu sau sinh", "rối loạn đông máu sau sinh", 
"đẻ khó", "có thai ngoài tử cung", "phẫu thuật sinh mổ", "sinh thường", "sinh mổ", "rối loạn nội tiết tố sau sinh", 
"tử cung co thắt", "tắc nghẽn đường sinh dục", "viêm dạ dày thai kỳ", "nhiễm trùng tiết niệu thai kỳ", "tắc nghẽn tử cung", 
"hoặc băng huyết sau sinh", "dạ dày thai kỳ", "bệnh lý thai nghén", "u nang tuyến vú", "bệnh lý niêm mạc tử cung", 
"có thai phụ", "chế độ ăn thai kỳ", "tình trạng tiền sản giật", "tiền sản giật nặng", "dị tật thai nhi", "đau bụng dưới", 
"thai kỳ muộn", "hội chứng thiếu máu thai kỳ", "bệnh lý do thai nghén", "hội chứng sinh non", "viêm nhiễm sau sinh", 
"bệnh lý sản khoa", "bệnh lý cổ tử cung sau sinh", "nhiễm trùng trong thai kỳ", "bệnh lý tuyến giáp thai kỳ", 
"cảnh giác với băng huyết sau sinh", "điều trị sản khoa", "bệnh lý ung thư sau sinh", "tăng cân quá mức khi mang thai", 
"tăng huyết áp trong thai kỳ", "suy thai cấp", "thai chết trong tử cung", "thai ối vỡ sớm", "viêm phụ khoa", 
"phẫu thuật sinh mổ cấp cứu", "phẫu thuật sinh mổ thai kỳ", "tăng huyết áp thai kỳ nặng", "hội chứng sinh non", 
"đau bụng mang thai", "viêm âm đạo do nấm", "viêm tử cung sau sinh", "suy dinh dưỡng thai nhi", "sinh mổ cấp cứu", 
"khó sinh", "nhiễm trùng hậu sản", "viêm tử cung sau sinh", "viêm amidan thai kỳ", "tổn thương sinh dục", "chửa trứng thai kỳ", 
"bệnh nhiễm trùng thai kỳ", "bệnh lý huyết học thai kỳ", "rối loạn huyết áp thai kỳ", "sinh thường kéo dài", 
"hoại tử tử cung sau sinh", "u nang buồng trứng sau sinh", "nhiễm trùng ruột sau sinh", "mất máu sau sinh", 
"hoảng loạn sinh con", "đau dạ dày thai kỳ", "sinh non sớm", "hội chứng tiền sản giật nặng", "suy giảm dinh dưỡng thai kỳ", 
"chuyển dạ sớm", "viêm ruột sau sinh", "hoại tử sau sinh", "tình trạng sau sinh", "tình trạng thai nhi", 
"rối loạn tiêu hóa sau sinh", "thai kỳ nguy cơ cao", "u xơ tử cung khi mang thai", "tình trạng đái tháo đường thai kỳ"],
  'Ngoại' : ["chấn thương", "gãy xương", "rạn xương", "vết thương", "nhiễm trùng vết thương", "cắt bỏ khối u", "u lành tính", 
"u ác tính", "viêm ruột thừa", "thoát vị", "tắc ruột", "tắc mật", "viêm loét dạ dày", "sỏi mật", "u tuyến giáp", 
"viêm túi mật", "lúm đồng tiền", "nhiễm trùng huyết", "viêm mạch máu", "chảy máu", "tăng huyết áp", "suy tim", 
"cắt bỏ tử cung", "sinh mổ", "phẫu thuật mạch máu", "bệnh tim mạch", "viêm cầu thận", "phẫu thuật nội soi", 
"thoái hóa khớp", "viêm khớp", "tắc nghẽn phổi", "mổ tim", "mổ gan", "mổ phổi", "mổ thận", "mổ xương", "mổ mạch máu", 
"phẫu thuật cắt bỏ khối u", "tắc nghẽn động mạch", "bệnh lý mạch máu", "cắt bỏ u xơ tử cung", "viêm phổi", 
"tổn thương tủy sống", "đứt gân", "lật mắt cá", "gãy xương cổ tay", "viêm gân", "viêm khớp gối", "viêm cơ", 
"nhiễm trùng khớp", "suy hô hấp", "phẫu thuật cắt ruột thừa", "viêm đường tiết niệu", "u nang buồng trứng", 
"tổn thương cột sống", "cắt bỏ ruột thừa", "viêm loét dạ dày tá tràng", "rối loạn tiêu hóa", "mổ cắt gan", 
"viêm dạ dày", "viêm túi mật cấp", "thoái hóa cột sống", "tăng mỡ máu", "lách to", "phẫu thuật thận", "tắc động mạch", 
"lỗ rò", "viêm phổi", "u tế bào thần kinh", "bệnh mạch máu", "đau lưng", "tổn thương dây thần kinh", 
"viêm màng bụng", "suy tim xung huyết", "viêm ruột", "ung thư dạ dày", "cắt bỏ khối u dạ dày", "thoái hóa khớp gối", 
"cắt u vú", "viêm tắc tĩnh mạch", "viêm đại tràng", "viêm ruột già", "gãy xương đùi", "cắt bỏ tuyến giáp", 
"viêm tuyến giáp", "tăng huyết áp động mạch", "viêm bao hoạt dịch", "phẫu thuật cắt phổi", "phẫu thuật gan", 
"u bàng quang", "tắc nghẽn mạch vành", "tổn thương mạch máu", "mổ cắt bỏ khối u", "bệnh lý tim mạch", "mổ tái tạo gân", 
"u tuyến yên", "tổn thương cột sống cổ", "cắt bỏ thận", "cắt bỏ gan", "tắc đường hô hấp", "phẫu thuật cắt khối u gan", 
"u tuyến vú", "tắc ruột non", "viêm ruột non", "viêm vú", "cắt tuyến vú", "tổn thương tủy sống", "phẫu thuật gãy xương", 
"tổn thương xương đùi", "phẫu thuật mổ cổ tử cung", "tổn thương dây chằng", "phẫu thuật cắt cổ tử cung", "tắc nghẽn tuyến tiền liệt", 
"tổn thương ổ bụng", "tổn thương phổi", "tổn thương não", "tổn thương nặng", "phẫu thuật nối ruột", "chấn thương đầu", 
"phẫu thuật thay khớp", "viêm phúc mạc", "phẫu thuật cắt dạ dày", "viêm khớp ngón tay", "cắt bỏ thận trái", "phẫu thuật xương", 
"tổn thương xương chậu", "mổ u buồng trứng", "tổn thương các cơ quan trong cơ thể", "tổn thương mô mềm", "tổn thương mô xương"],

  'Nội':["viêm phổi", "suy tim", "tăng huyết áp", "viêm gan", "viêm dạ dày", "tiểu đường", "mỡ máu cao", "loãng xương", 
"chảy máu dạ dày", "bệnh tim mạch", "suy thận", "rối loạn tiêu hóa", "đau thắt ngực", "suy hô hấp", "tắc nghẽn mạch máu", 
"viêm tụy", "bệnh phổi tắc nghẽn mãn tính", "ung thư phổi", "bệnh lý mạch máu", "viêm đại tràng", "sỏi thận", 
"bệnh lý gan", "nhiễm trùng huyết", "u tuyến giáp", "viêm loét đại tràng", "cảm cúm", "viêm túi mật", "bệnh viêm khớp", 
"tăng huyết áp động mạch", "đau bụng", "tiêu chảy", "viêm nhiễm đường hô hấp", "tắc nghẽn đường hô hấp", "phổi tắc nghẽn", 
"viêm cơ tim", "bệnh mạch vành", "đau ngực", "u gan", "bệnh động mạch vành", "rối loạn lipid máu", "bệnh thiếu máu", 
"phì đại tuyến tiền liệt", "bệnh thận mạn tính", "suy tim trái", "bệnh tiểu đường type 2", "hội chứng thận hư", "tăng cholesterol", 
"chứng lo âu", "viêm màng não", "rối loạn nội tiết", "viêm phổi tắc nghẽn mãn tính", "bệnh lý huyết học", "tăng tiểu cầu", 
"mạch vành", "suy giảm miễn dịch", "hội chứng đau ngực", "tắc nghẽn động mạch", "viêm cầu thận", "đột quỵ", 
"rối loạn chuyển hóa", "tăng đường huyết", "viêm cơ", "tắc nghẽn phổi", "tăng huyết áp phổi", "bệnh thiếu máu", 
"ung thư dạ dày", "viêm gan siêu vi", "viêm đại tràng mạn tính", "nhiễm trùng đường tiết niệu", "viêm gan cấp", 
"bệnh lý thần kinh", "đau đầu", "ho kéo dài", "nhiễm trùng dạ dày", "suy gan", "tổn thương gan", "bệnh u tuyến vú", 
"tiểu đường thai kỳ", "suy hô hấp mạn tính", "bệnh lý về da", "tăng tiểu cầu", "hội chứng Cushing", "nhiễm trùng đường ruột", 
"ung thư ruột", "bệnh lý viêm khớp", "tắc nghẽn ruột", "nhiễm khuẩn huyết", "viêm phúc mạc", "viêm tuyến giáp", 
"cổ trướng", "đau lưng", "hội chứng chuyển hóa", "tổn thương thận", "tổn thương gan mật", "hội chứng thận cấp", 
"loét dạ dày", "tổn thương cơ tim", "rối loạn tiêu hóa mãn tính", "hội chứng mạch máu", "bệnh mạch máu ngoại biên", 
"tăng sản tuyến giáp", "đái tháo đường type 1", "rối loạn huyết áp", "môi trường nội tiết", "bệnh lý tuyến vú", 
"viêm tuyến giáp", "tăng huyết áp mạn tính", "tăng triglycerid máu", "bệnh thiếu máu não", "chóng mặt", "viêm phổi cấp", 
"u vú", "mờ mắt", "bệnh thận đa nang", "suy hô hấp cấp", "bệnh tiểu đường type 1", "rối loạn giấc ngủ", "suy giáp", 
"viêm khớp dạng thấp", "chóng mặt, buồn nôn", "lupus ban đỏ", "hội chứng gan mật", "hoặc đau ngực", "suy tim mạn tính"],
};

//DÙNG ĐỂ CHỈNH SỬA MỘT CUỘC HỌP SẮP DIỄN RA
DateTime tempDateTime = DateTime.now();

//NGÀY THÁNG TRONG TIẾNG VIỆT
const daysInVietnamese = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
const monthsInVietnamese = ['Tháng Một','Tháng Hai','Tháng Ba','Tháng Tư','Tháng Năm','Tháng Sáu','Tháng Bảy','Tháng Tám','Tháng Chín','Tháng Mười','Tháng Mười Một','Tháng Mười Hai',];

//DÙNG TRONG CÁC METHOD ADD
String newestID = "";

//MẬT KHẨU TÀI KHOẢN ĐĂNG NHẬP
Map <String,String> loginAccount = {
  'nguyenlekhanh13@gmail.com' : 'nguyendz123',
  '1@2.com' : '1',
};

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false; // Luôn luôn không cho phép focus
}
Container showAddingID(String label, int type){
  switch (type){
    case 0: //TẠO ID MỚI CHO 1 PATIENT
      List<bool> check=List.filled(patientLastestID+1, false);
      for( var patient in allPatient.values ){
        check[int.parse(patient.patientID.substring(2))] = true;
      }
      int latestID = patientLastestID;
      for(int i = 1 ; i < check.length ; i++){
        if( !check[i] ){
          latestID = i;
          break;
        }
      } 
      newestID = 'BN${'$latestID'.padLeft(6,'0')}';
      if( newestID == 'BN${'$patientLastestID'.padLeft(6,'0')}' ){
        newestID = 'BN${'${patientLastestID+1}'.padLeft(6,'0')}';
      }
      break;
    case 1: //TẠO ID MỚI CHO 1 DOCTOR
      List<bool> check=List.filled(doctorLastestID+1, false);
      for( var doctor in allDoctors.values ){
        check[int.parse(doctor.IDWorker.substring(2))] = true;
      }
      int latestID = doctorLastestID;
      for(int i = 1 ; i < check.length ; i++){
        if( !check[i] ){
          latestID = i;
          break;
        }
      } 
      newestID = 'DT${'$latestID'.padLeft(6,'0')}';
      if( newestID == 'DT${'$doctorLastestID'.padLeft(6,'0')}' ){
        newestID = 'DT${'${doctorLastestID+1}'.padLeft(6,'0')}';
      }
      break;
    case 2: //TẠO ID MỚI CHO 1 APPOINMENT
      List<bool> check=List.filled(appoinmentLastestID+1, false);
      for ( var list in kAppointments.values ){
        for(var appoinment in list){
           check[int.parse(appoinment.appoinmentID.substring(2))] = true;
        }
      }
      int latestID = appoinmentLastestID;
      for(int i = 1 ; i < check.length ; i++){
        if( !check[i] ){
          latestID = i;
          break;
        }
      } 
      newestID = 'CH${'$latestID'.padLeft(6,'0')}';
      if( newestID == 'CH${'$appoinmentLastestID'.padLeft(6,'0')}' ){
        newestID = 'CH${'${appoinmentLastestID+1}'.padLeft(6,'0')}';
      }
      break;
  }

  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: newestID,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      )
      ),
  );
}

//SHOW 1 ĐOẠN VĂN BẢN KHÔNG THỂ CHỈNH SỬA, CÓ CHỮ NỔI PHÍA TRÊN
TextField showNoChangeInfo(String label, String title){
  return TextField(
        focusNode: AlwaysDisabledFocusNode(),
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      );
}

//SHO 1 CONTAINER CHỨA VĂN BẢN KHÔNG THỂ CHỈNH SỬA, CÓ CHỮ NỔI PHÍA TRÊN
Container showNoChangeInfoContainer(String label,String title){
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: showNoChangeInfo(label, title) 
      
      ),
    );
}

Container showID(String label,String id){
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: id,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      )
      ),
    );
}

//SHOW 1 ĐOẠN VĂN BẢN DÙNG ĐỂ ĐIỀN TRONG METHOD ADD
Container fillblank(final TextEditingController controller, String s) {
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: s,
          border: const UnderlineInputBorder(),
        ),
      ),
    ),
  );
}

Container adjustGenderDropdown(GenderEnum selectedGender) {
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding * 2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: DropdownButton<GenderEnum>(
        value: selectedGender,
        isExpanded: true,
        onChanged: (GenderEnum? value) {
          
        } ,
        items: GenderEnum.values.map((GenderEnum gender) {
          return DropdownMenuItem<GenderEnum>(
            value: gender,
            child: Text(
              genderToString(gender),
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        underline: const SizedBox(), // Loại bỏ gạch dưới
      ),
    ),
  );
}

String genderToString(GenderEnum gender) {
  switch (gender) {
    case GenderEnum.male:
      return 'Nam';
    case GenderEnum.female:
      return 'Nữ';
    case GenderEnum.other:
      return 'Khác';
  }
}
//SHOW 1 ĐOẠN VĂN BẢN DÙNG CHỈNH SỬA TRONG METHOD ADJUST
Container adjustblank(final TextEditingController controller, String label, String init) {
  controller.text = init;
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //hintText: init,
          border: const UnderlineInputBorder(),
        ),
      ),
    ),
  );
}

//SHOW FLUSH BAR THÀNH CÔNG
void showCompleteFlushBar(BuildContext context, String title){
  Flushbar(
    backgroundColor: lightGreenBackground,
    title: 'Thông báo:',
    titleSize: 24,
    titleColor: textBlackColor,
    messageSize: 24,
    message: title,
    messageColor: textBlackColor,
    icon: const Icon(
      Icons.assignment_turned_in,
      size: 28,
      color: textBlackColor,
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}
//SHOW FLUSH BAR LỖI
void showErorrFlushBar(BuildContext context, String title){
  Flushbar(
    backgroundColor: selectedColor,
    title: 'Lỗi',
    titleSize: 24,
    titleColor: textBlackColor,
    messageSize: 24,
    message: title,
    messageColor: textBlackColor,
    icon: const Icon(
      Icons.warning_amber_rounded,
      size: 28,
      color: Colors.yellow,
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}

//CÁC LOẠI MÀU CỐ ĐỊNH
const Color selectedColor = Color(0xFFF26D3D);
const Color weekendColor = Color(0xFFFFC8C4);
const Color veryGreenBackground = Color(0xFF023336);
const Color mediumGreenBackground = Color(0xFF4DA674);
const Color lightGreenBackground = Color(0xFFC1E6BA);
const Color whiteGreenBackground = Color(0xFFEAF8E7);
const Color textBlackColor = Color(0xFF313131);
const Color textWhiteColor = Color(0xFFFFFFFF);
const Color errorBorderColor = Color(0xFFE74C3C);
const double defaultPadding = 20.0;
//1 ĐOẠN VĂN BẢN HỢP LỆ THEO CÚ PHÁP
const String mobilePattern = r'^(0[0-9]{9,})$';
const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';