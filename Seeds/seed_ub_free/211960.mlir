module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<82> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<1.486000e+02> : tensor<1x2x3xf32>}> : () -> tensor<1x2x3xf32>
    %2 = tosa.bitwise_not %0 : (tensor<i16>) -> tensor<i16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.negate %2, %3, %4 : (tensor<i16>, tensor<1xi16>, tensor<1xi16>) -> tensor<i16>
    %6 = tosa.clamp %5 {max_val = 91 : i16, min_val = 62 : i16} : (tensor<i16>) -> tensor<i16>
    %7 = tosa.sigmoid %1 : (tensor<1x2x3xf32>) -> tensor<1x2x3xf32>
    %8 = tosa.argmax %7 {axis = 1 : i32} : (tensor<1x2x3xf32>) -> tensor<1x3xi32>
    %9 = tosa.maximum %7, %7 : (tensor<1x2x3xf32>, tensor<1x2x3xf32>) -> tensor<1x2x3xf32>
    %10 = tosa.rsqrt %9 : (tensor<1x2x3xf32>) -> tensor<1x2x3xf32>
    %11 = tosa.reverse %9 {axis = 1 : i32} : (tensor<1x2x3xf32>) -> tensor<1x2x3xf32>
    %cast = tensor.cast %6 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<1x3xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<1x2x3xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %11 : tensor<1x2x3xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}

