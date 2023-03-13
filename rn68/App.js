/* eslint-disable react-hooks/exhaustive-deps */
import {NavigationContainer} from '@react-navigation/native';
import React from 'react';
import {Button, ScrollView, Text} from 'react-native';
import {createNativeStackNavigator} from 'react-native-screens/native-stack';

export function Home({navigation}) {
  const sbRef = React.useRef(null);
  const [search, setSearch] = React.useState('');

  const searchBarOptions = {
    // @ts-ignore
    ref: sbRef,
    barTintColor: 'powderblue',
    hideWhenScrolling: true,
    obscureBackground: false,
    hideNavigationBar: false,
    autoCapitalize: 'sentences',
    placeholder: 'Some text',
    onChangeText: e => setSearch(e.nativeEvent.text),
    onCancelButtonPress: () => console.warn('Cancel button pressed'),
    onSearchButtonPress: () => console.warn('Search button pressed'),
    onFocus: () => console.warn('onFocus event'),
    onBlur: () => console.warn('onBlur event'),
  };

  React.useEffect(() => {
    navigation.setOptions({
      searchBar: searchBarOptions,
    });
  }, [navigation]);

  return (
    <ScrollView>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Text>Some text</Text>
      <Button title="Focus search bar" onPress={() => sbRef.current.focus()} />
      <Button title="Blur search bar" onPress={() => sbRef.current.blur()} />
    </ScrollView>
  );
}

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerLargeTitle: true,
          headerTranslucent: true,
        }}>
        <Stack.Screen name="Home" component={Home} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
