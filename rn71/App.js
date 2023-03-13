import * as React from 'react';
import {useEffect, useState} from 'react';
import {View, TouchableOpacity, Text} from 'react-native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {NavigationContainer} from '@react-navigation/native';

const MainStack = createNativeStackNavigator();

function App() {
  const [userLoading, setUserLoading] = useState(true);

  useEffect(() => {
    setUserLoading(false);
  }, []);

  // Just show a splashscreen if either are loading
  // if (userLoading) {
  //   return <SplashScreen />;
  // }

  return (
    <NavigationContainer>
      <MainStack.Navigator>
        <MainStack.Screen name={'FirstScreen'} component={FirstScreen} />
        <MainStack.Screen name="SecondScreen" component={SecondScreen} />
      </MainStack.Navigator>
    </NavigationContainer>
  );
}

const FirstScreen = ({navigation}: any) => {
  return (
    <View style={{flex: 1, alignContent: 'center', justifyContent: 'center'}}>
      <TouchableOpacity
        style={{backgroundColor: 'cyan', padding: 20}}
        onPress={() => navigation.navigate('SecondScreen')}
      >
        <Text>Go forward</Text>
      </TouchableOpacity>
    </View>
  );
};

const SecondScreen = ({navigation}: any) => {
  return (
    <View style={{flex: 1, alignContent: 'center', justifyContent: 'center'}}>
      <TouchableOpacity
        style={{backgroundColor: 'magenta', padding: 20}}
        onPress={() => navigation.goBack()}
      >
        <Text>Go Back</Text>
      </TouchableOpacity>
    </View>
  );
};

// const SplashScreen = () => {
//   return (
//     <Animated.View
//       style={{
//         backgroundColor: 'black',
//         flex: 1,
//       }}
//       exiting={FadeOut}
//     />
//   );
// };

export default App;