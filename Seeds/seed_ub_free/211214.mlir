module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.537000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<76> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<83> : tensor<i16>}> : () -> tensor<i16>
    %3 = tosa.rsqrt %0 : (tensor<1xf32>) -> tensor<1xf32>
    %4 = tosa.sigmoid %3 : (tensor<1xf32>) -> tensor<1xf32>
    %5 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %6 = tosa.reciprocal %5 : (tensor<1xf32>) -> tensor<1xf32>
    %7 = tosa.tanh %6 : (tensor<1xf32>) -> tensor<1xf32>
    %8 = tosa.tanh %7 : (tensor<1xf32>) -> tensor<1xf32>
    // UB fix for tosa.logical_left_shift: shift amount for i16 must be in [0, 15]. Input %2 (83) is out of range.
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i16>}> : () -> tensor<i16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<i16>}> : () -> tensor<i16>
    %t0 = tosa.maximum %2, %c0 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %t1 = tosa.minimum %t0, %c1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %9 = tosa.logical_left_shift %1, %t1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %10 = tosa.bitwise_or %9, %9 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    // UB fix for tosa.pow: inputs %6 and %3 are NaN, violating !isNaN and is_finite requirements.
    // Also value1 >= 0 and (value1 > 0 || value2 > 0) are required.
    // Clamping NaN inputs to 1.0 satisfies all conditions.
    %c2 = "tosa.const"() <{values = dense<1.0> : tensor<1xf32>}> : () -> tensor<1xf32>
    %t2 = tosa.maximum %6, %c2 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %t3 = tosa.maximum %3, %c2 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %11 = tosa.pow %t2, %t3 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %12 = tosa.sub %10, %10 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %13 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %14 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %15 = tosa.negate %12, %13, %14 : (tensor<i16>, tensor<1xi16>, tensor<1xi16>) -> tensor<i16>
    %16 = tosa.reduce_product %11 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %17 = tosa.sub %9, %9 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %18 = tosa.reciprocal %11 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %8 : tensor<1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %15 : tensor<i16> to tensor<*xi16>
    %cast_1 = tensor.cast %16 : tensor<1xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %17 : tensor<i16> to tensor<*xi16>
    %cast_3 = tensor.cast %18 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_2) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_3) : (tensor<*xf32>) -> ()
    return
  }
}