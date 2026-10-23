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
    %9 = tosa.logical_left_shift %1, %2 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %10 = tosa.bitwise_or %9, %9 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %11 = tosa.pow %6, %3 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
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

