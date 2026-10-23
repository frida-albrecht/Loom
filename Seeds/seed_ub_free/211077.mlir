module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-109> : tensor<2x4x3xi16>}> : () -> tensor<2x4x3xi16>
    %1 = "tosa.const"() <{values = dense<7.683000e+01> : tensor<5x3x9xf32>}> : () -> tensor<5x3x9xf32>
    %2 = "tosa.const"() <{values = dense<-1.266300e+02> : tensor<5x3x1xf32>}> : () -> tensor<5x3x1xf32>
    %3 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %4 = tosa.transpose %0 {perms = array<i32: 0, 2, 1>} : (tensor<2x4x3xi16>) -> tensor<2x3x4xi16>
    %5 = tosa.pow %1, %2 : (tensor<5x3x9xf32>, tensor<5x3x1xf32>) -> tensor<5x3x9xf32>
    %6 = tosa.pow %5, %5 : (tensor<5x3x9xf32>, tensor<5x3x9xf32>) -> tensor<5x3x9xf32>
    %7 = tosa.rsqrt %5 : (tensor<5x3x9xf32>) -> tensor<5x3x9xf32>
    %8 = tosa.clamp %6 {max_val = 6.600000e+01 : f32, min_val = -4.900000e+01 : f32} : (tensor<5x3x9xf32>) -> tensor<5x3x9xf32>
    %9 = tosa.exp %7 : (tensor<5x3x9xf32>) -> tensor<5x3x9xf32>
    %10 = tosa.bitwise_xor %4, %4 : (tensor<2x3x4xi16>, tensor<2x3x4xi16>) -> tensor<2x3x4xi16>
    %11 = tosa.concat %8, %7 {axis = 0 : i32} : (tensor<5x3x9xf32>, tensor<5x3x9xf32>) -> tensor<10x3x9xf32>
    %cast = tensor.cast %9 : tensor<5x3x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<2x3x4xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %11 : tensor<10x3x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

