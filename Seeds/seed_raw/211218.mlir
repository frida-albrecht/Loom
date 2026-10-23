module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.380000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.625600e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<-10> : tensor<4x6x8xi8>}> : () -> tensor<4x6x8xi8>
    %3 = tosa.pow %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.negate %3, %4, %5 : (tensor<f32>, tensor<1xf32>, tensor<1xf32>) -> tensor<f32>
    %7 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %8 = tosa.transpose %2 {perms = array<i32: 0, 2, 1>} : (tensor<4x6x8xi8>) -> tensor<4x8x6xi8>
    %9 = tosa.reverse %8 {axis = 1 : i32} : (tensor<4x8x6xi8>) -> tensor<4x8x6xi8>
    %10 = tosa.add %9, %9 : (tensor<4x8x6xi8>, tensor<4x8x6xi8>) -> tensor<4x8x6xi8>
    %cast = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<4x8x6xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

