fullname=$(basename -- "$1")
extension="${fullname##*.}"
filename="${fullname%.*}"
if [ $extension == "m4a" ]; then
    file="${filename}.wav"
    ffmpeg -i $fullname $file
    rm $1
else
    file=$1
fi
sox $file -r 8000 temp.wav remix -
sox temp.wav $file
rm temp.wav
python dualrnn_test_wav.py -mix_scp $file -yaml config/Dual_RNN/train_rnn.yml -model checkpoint/Dual_Path_RNN/best.pt -save_path demo_output
