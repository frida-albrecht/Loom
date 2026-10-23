module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-10> : tensor<3x10x2xi8>}> : () -> tensor<3x10x2xi8>
    %1 = "tosa.const"() <{values = dense<-8.394000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.clamp %0 {max_val = 45 : i8, min_val = -2 : i8} : (tensor<3x10x2xi8>) -> tensor<3x10x2xi8>
    %3 = tosa.clamp %2 {max_val = 45 : i8, min_val = -2 : i8} : (tensor<3x10x2xi8>) -> tensor<3x10x2xi8>
    %4 = tosa.reduce_min %3 {axis = 2 : i32} : (tensor<3x10x2xi8>) -> tensor<3x10x1xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<3x10x1xi8>}> : () -> tensor<3x10x1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<3x10x1xi8>}> : () -> tensor<3x10x1xi8>
    %l1 = tosa.maximum %4, %c0 : (tensor<3x10x1xi8>, tensor<3x10x1xi8>) -> tensor<3x10x1xi8>
    %l2 = tosa.minimum %l1, %c7 : (tensor<3x10x1xi8>, tensor<3x10x1xi8>) -> tensor<3x10x1xi8>
    %5 = tosa.logical_left_shift %4, %l2 : (tensor<3x10x1xi8>, tensor<3x10x1xi8>) -> tensor<3x10x1xi8>
    %6 = tosa.concat %5, %5 {axis = 1 : i32} : (tensor<3x10x1xi8>, tensor<3x10x1xi8>) -> tensor<3x20x1xi8>
    %7 = tosa.rsqrt %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %6 : tensor<3x20x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}