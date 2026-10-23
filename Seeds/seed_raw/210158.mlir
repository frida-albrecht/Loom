module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<6x9xi8>}> : () -> tensor<6x9xi8>
    %1 = "tosa.const"() <{values = dense<1.213100e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %2 = "tosa.const"() <{values = dense<-1.768700e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %3 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<6x9xi8>) -> tensor<1x9xi8>
    %4 = tosa.pow %1, %2 : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    %5 = tosa.pow %4, %4 : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    %cast = tensor.cast %3 : tensor<1x9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<5xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

