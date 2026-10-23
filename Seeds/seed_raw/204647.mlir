module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.522000e+01> : tensor<9x2x8x6xf32>}> : () -> tensor<9x2x8x6xf32>
    %1 = "tosa.const"() <{values = dense<-5> : tensor<i8>}> : () -> tensor<i8>
    %2 = tosa.exp %0 : (tensor<9x2x8x6xf32>) -> tensor<9x2x8x6xf32>
    %3 = tosa.bitwise_not %1 : (tensor<i8>) -> tensor<i8>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.negate %2, %4, %5 : (tensor<9x2x8x6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<9x2x8x6xf32>
    %7 = tosa.const_shape  {values = dense<[1, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %8 = tosa.tile %6, %7 : (tensor<9x2x8x6xf32>, !tosa.shape<4>) -> tensor<9x2x24x6xf32>
    %9 = tosa.bitwise_or %3, %3 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %10 = tosa.rsqrt %6 : (tensor<9x2x8x6xf32>) -> tensor<9x2x8x6xf32>
    %11 = tosa.concat %2, %6 {axis = 0 : i32} : (tensor<9x2x8x6xf32>, tensor<9x2x8x6xf32>) -> tensor<18x2x8x6xf32>
    %12 = tosa.clz %3 : (tensor<i8>) -> tensor<i8>
    %cast = tensor.cast %8 : tensor<9x2x24x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<i8> to tensor<*xi8>
    %cast_1 = tensor.cast %10 : tensor<9x2x8x6xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %11 : tensor<18x2x8x6xf32> to tensor<*xf32>
    %cast_3 = tensor.cast %12 : tensor<i8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_3) : (tensor<*xi8>) -> ()
    return
  }
}

