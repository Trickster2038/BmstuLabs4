a1 = ["Lada Granta", 685_500.0, 358.0, 13.3, 10.7]
a2 = ["Lada Vesta", 676_900.0, 294.0, 14.1, 15.1]
a3 = ["Kia Rio", 969_000.0, 285.0, 12.9, 13.6]
a4 = ["Hyndai Creta", 1_177_000, 316.0, 12.1, 15.7]
a5 = ["Volkswagen Polo", 1_064_900, 329.0, 11.8, 14.3]

def rate(chrs)
	print("\n\n=== #{chrs[0]} ===")
	print("\nCost: #{100*(2_500_000 - chrs[1]) / 2_000_000 }")
	print("\nFuel: #{100*(600 - chrs[2]) / 400}")
	print("\nAcceleration: #{100*(17-chrs[3]) / 6}")
	print("\nSafety: #{100*(chrs[4]-8) / 8}")
end

rate(a1)
rate(a2)
rate(a3)
rate(a4)
rate(a5)