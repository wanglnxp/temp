import requests
import json
import collections
import sys


class Person:
    """
    Class for storing a person's information and his firends list
    """

    def __init__(self, id_num, name, friends):
        self.id_num = id_num
        self.name = name
        self.friends = friends

    def get_friend(self):
        return self.friends

    def get_name(self):
        return self.name

    def get_id(self):
        return self.id_num


def build_person(id_num):
    """
    this function request the information from API and put this information into Person object
    :param id_num: the person user want to query
    :return: Person object
    """
    response = requests.get("http://fg-69c8cbcd.herokuapp.com/user/" + str(id_num))
    data = json.loads(response.text)
    person = Person(data['id'], data['name'], data['friends'])
    return person


def build_friends(id_list):
    """
    this function help putting a list of friends into Person object and add into a list
    :param id_list: list of friend ID
    :return: list of friend in form of Person object
    """
    all_friends = []
    for id_num in id_list:
        all_friends.append(build_person(id_num))
    return all_friends


def print_relation(id_num):
    """
    Main function which does BFS and 
    :param id_num: person id to start the search
    :return: a dictionary contains list of friends and friends-of-friends
    """
    root = build_person(id_num)
    # visited record all the people we have visited
    visited = {id_num}
    # more_friend record people we are going to visit
    more_friend = build_friends(root.friends)
    # result record all the relationships, using ordered dictionary so root is always at first
    result = collections.OrderedDict()
    result[root.name] = [name for name in more_friend]
    # print_one_result(root.name, result[root.name])
    # BFS loop to find all friends of friends
    while more_friend:
        to_add = []
        for friend in more_friend:
            # if we have visited this person, skip
            if friend.id_num in visited:
                continue
            else:
                visited.add(friend.id_num)
                # find all friends of this friend
                friends_of_friend = build_friends(friend.friends)
                # record into result
                result[friend.name] = [name for name in friends_of_friend]
                # print_one_result(friend.name, result[friend.name])
                # will visited all his/her friends in next loop
                to_add += friends_of_friend
        more_friend = to_add

    print_result(result)
    return result


"""
Below are function for test purpose, use for printing information
"""


def print_one_result(key, value):
    print key + ": ",
    for friend in value:
        print friend.name + " ",
    print


def print_result(result_dic):
    for key, value in result_dic.iteritems():
        print key + ": ",
        for friend in value:
            print friend.name + " ",
        print


if __name__ == '__main__':
    if len(sys.argv)!= 2:
        print "usage: Question1.py <user ID>"
    else:
        print_relation(sys.argv[1])
