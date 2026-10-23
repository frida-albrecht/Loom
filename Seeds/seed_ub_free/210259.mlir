module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.549200e+02> : tensor<4x6x7xf32>}> : () -> tensor<4x6x7xf32>
    %1 = "tosa.const"() <{values = dense<-1.199000e+02> : tensor<1x1x7xf32>}> : () -> tensor<1x1x7xf32>
    %2 = "tosa.const"() <{values = dense<-19> : tensor<6x7x8x9xi8>}> : () -> tensor<6x7x8x9xi8>
    // For tosa.pow op with %0 (base) and %1 (exponent):
    // Requirement 1: base (value1) must be >= 0. %0 has negative values.
    // Fix: Clamp %0 to be at least 0.0 using tosa.maximum.
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<4x6x7xf32>}> : () -> tensor<4x6x7xf32>
    %s1 = tosa.maximum %0, %c0 : (tensor<4x6x7xf32>, tensor<4x6x7xf32>) -> tensor<4x6x7xf32>

    // Requirement 2: (value1 > 0 || value2 > 0).
    // After the first fix, %s1 (new base) is dense<0.0>. So, value1 > 0 is false.
    // This implies that value2 (exponent) must be > 0.
    // %1 (original exponent) is dense<-1.199000e+02>, which is not > 0.
    // Fix: Clamp %1 to be at least 1.0 to ensure it's strictly positive.
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<1x1x7xf32>}> : () -> tensor<1x1x7xf32>
    %s2 = tosa.maximum %1, %c1 : (tensor<1x1x7xf32>, tensor<1x1x7xf32>) -> tensor<1x1x7xf32>

    %3 = tosa.pow %s1, %s2 : (tensor<4x6x7xf32>, tensor<1x1x7xf32>) -> tensor<4x6x7xf32>
    %4 = tosa.reduce_min %3 {axis = 2 : i32} : (tensor<4x6x7xf32>) -> tensor<4x6x1xf32>
    %5 = tosa.identity %4 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %6 = tosa.exp %5 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %7 = tosa.reciprocal %6 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %8 = tosa.clz %2 : (tensor<6x7x8x9xi8>) -> tensor<6x7x8x9xi8>
    %9 = tosa.maximum %7, %7 : (tensor<4x6x1xf32>, tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %10 = tosa.ceil %9 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %11 = tosa.tanh %10 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %12 = tosa.minimum %8, %8 : (tensor<6x7x8x9xi8>, tensor<6x7x8x9xi8>) -> tensor<6x7x8x9xi8>
    %13 = tosa.reduce_min %12 {axis = 1 : i32} : (tensor<6x7x8x9xi8>) -> tensor<6x1x8x9xi8>
    %14 = tosa.exp %11 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %15 = tosa.abs %14 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %16 = tosa.sub %13, %13 : (tensor<6x1x8x9xi8>, tensor<6x1x8x9xi8>) -> tensor<6x1x8x9xi8>
    %17 = tosa.reduce_min %15 {axis = 0 : i32} : (tensor<4x6x1xf32>) -> tensor<1x6x1xf32>
    %18 = tosa.sigmoid %17 : (tensor<1x6x1xf32>) -> tensor<1x6x1xf32>
    %19 = tosa.sigmoid %18 : (tensor<1x6x1xf32>) -> tensor<1x6x1xf32>
    %cast = tensor.cast %16 : tensor<6x1x8x9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %19 : tensor<1x6x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}