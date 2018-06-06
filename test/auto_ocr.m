function [ocr,ocr_content]=auto_ocr(annotation,im)
imwrite(im,'tmp.pgm');
system('tesseract tmp.pgm tmp  -psm 7 letters');
file_path1 = 'tmp.txt';
fileID1 = fopen(file_path1);
result = fgetl(fileID1);
fclose(fileID1);
ocr_content = space2underline(result); %空格转为下划线
ocr=LevenshteinDistance(annotation,ocr_content);
