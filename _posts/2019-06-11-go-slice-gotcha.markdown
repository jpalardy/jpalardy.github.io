---
layout: post
title: "Go Slice Gotcha"
category: posts
---

Go is, _mostly_, a straightforward and unsurprising language.

One thing that caught me recently was the behavior of slices.

## The setup

{% highlight go %}
nums := []int{3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
chunk := nums[3:6]
fmt.Println("chunk:", chunk)   // chunk: [6 7 8]
{% endhighlight %}

A slice and a subslice; no surprises yet.

{% highlight go %}
chunk = append(chunk, 999)
{% endhighlight %}

What are the consequences of this `append`? **Spoilers ahead!**

## Oh no...

{% highlight go %}
fmt.Println("nums: ", nums)    // nums:  [3 4 5 6 7 8 999 10 11 12 13 14]
fmt.Println("chunk:", chunk)   // chunk: [6 7 8 999]
{% endhighlight %}

`chunk` contains what you would expect.

What about that `999` after 8 in the original slice?!

## Slice Capacity

The answer is not the `len`, check the `cap`

{% highlight go %}
len(nums[3:6])   // 3
cap(nums[3:6])   // 9
{% endhighlight %}

Why 9? Because the extra capacity of the original slice was carried over when
slicing. There were 9 elements from index 3 to the end of the slice:

{% highlight go %}
fmt.Println(nums[3:])   // [6 7 8 9 10 11 12 13 14]
len(nums[3:])           // 9
{% endhighlight %}

## The Solution

Go has a syntax to limit the `cap` when subslicing:

{% highlight go %}
len(nums[3:6:6])   // 3
cap(nums[3:6:6])   // 3
{% endhighlight %}

It's worth reading [Slice expressions](https://golang.org/ref/spec#Slice_expressions); especially the "Full slice expressions" subsection.

> a[low : high : max]

I found that [Go in Action](https://www.amazon.com/Go-Action-William-Kennedy/dp/1617291781/) (section 4.2.3) had a great explanation
on this:

> The purpose [of the third index] is not to increase capacity, but to restrict the capacity.

You're still sharing the underlying array, within the valid indices. If you try to append, it's a [copy on write](https://en.wikipedia.org/wiki/Copy-on-write).

## Conclusion

I'm just _surprised_ this syntax doesn't work the other way around:

{% highlight go %}
- nums[3:6]                 // gets only what you asked for?
- nums[3:6:cap(nums) - 3]   // gets you that extra capacity?
{% endhighlight %}

Ugly? Yes. But I like syntactic vinegar when doing things that aren't straightforward.

