function [ocr,ocr_content]=auto_ocr(annotation,im)
imwrite(im,'tmp.pgm');
cd D:\CNN\SRCNN&CDSR_in_matlab\VDSR
system('tesseract tmp.pgm tmp  -psm 7 letters');
file_path1 = 'D:\CNN\SRCNN&CDSR_in_matlab\VDSR\tmp.txt';
fileID1 = fopen(file_path1);
result = fgetl(fileID1);
fclose(fileID1);
ocr_content = space2underline(result); %�ո�תΪ�»���
ocr=LevenshteinDistance(annotation,ocr_content);
