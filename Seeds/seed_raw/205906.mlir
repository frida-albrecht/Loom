module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<98> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<87> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<1.667700e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-5> : tensor<10x7x4xi8>}> : () -> tensor<10x7x4xi8>
    %4 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.reciprocal %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reverse %3 {axis = 2 : i32} : (tensor<10x7x4xi8>) -> tensor<10x7x4xi8>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %6 : tensor<10x7x4xi8> to tensor<*xi8>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}

