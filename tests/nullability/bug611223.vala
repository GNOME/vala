void main() {
	string? nullable = null;
	string non_null = nullable ?? "";
	string? some_null = nullable ?? null;
	string also_non_null = null ?? non_null;
	string really_non_null = non_null ?? nullable;
}
