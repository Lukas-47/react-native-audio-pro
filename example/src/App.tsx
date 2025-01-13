import { useEffect } from 'react';
import {
  Alert,
  Button,
  Image,
  SafeAreaView,
  StyleSheet,
  View,
} from 'react-native';
import {
  addEventListener,
  AudioProEvent,
  type AudioProMediaFile,
  load,
  pause,
  play,
  stop,
} from 'react-native-audio-pro';

const App = () => {
  useEffect(() => {
    const onBuffering = addEventListener(AudioProEvent.BUFFERING, () => {
      console.log('Buffering...');
      Alert.alert('Buffering');
    });
    const onPlaying = addEventListener(AudioProEvent.PLAYING, (payload) => {
      console.log('Playing:', payload);
      Alert.alert('Playing');
    });
    const onPaused = addEventListener(AudioProEvent.PAUSED, (payload) => {
      console.log('Paused:', payload);
      Alert.alert('Paused');
    });
    const onFinished = addEventListener(AudioProEvent.FINISHED, () => {
      console.log('Finished playback');
      Alert.alert('Finished');
    });
    const onError = addEventListener(AudioProEvent.ERROR, (error) => {
      console.log('Error:', error);
      Alert.alert('Error');
    });

    console.log('~~~ onPaused', onPaused);

    return () => {
      onBuffering.remove();
      onPlaying.remove();
      onPaused.remove();
      onFinished.remove();
      onError.remove();
      console.log('~~~ removing');
    };
  }, []);

  const mediaFile: AudioProMediaFile = {
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    title: 'SoundHelix Song 1',
    artist: 'SoundHelix',
    artwork: 'https://placehold.co/300',
  };

  return (
    <SafeAreaView style={styles.safe}>
      <View style={styles.container}>
        <Image source={{ uri: mediaFile.artwork }} style={styles.artwork} />
        <Button title="Load Audio" onPress={() => load(mediaFile)} />
        <Button title="Play Audio" onPress={play} />
        <Button title="Pause Audio" onPress={pause} />
        <Button title="Stop Audio" onPress={stop} />
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safe: {
    flex: 1,
    backgroundColor: '#333',
    justifyContent: 'center',
    alignItems: 'center',
  },
  container: {
    flex: 1,
  },
  artwork: {
    width: 150,
    height: 150,
    marginBottom: 16,
  },
});

export default App;
