module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-37> : tensor<3x5xi16>}> : () -> tensor<3x5xi16>
    %1 = "tosa.const"() <{values = dense<-1.252700e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %2 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<3x5xi16>) -> tensor<3x1xi16>
    %3 = tosa.reciprocal %1 : (tensor<7xf32>) -> tensor<7xf32>
    %4 = tosa.ceil %3 : (tensor<7xf32>) -> tensor<7xf32>
    %5 = tosa.tanh %3 : (tensor<7xf32>) -> tensor<7xf32>
    %6 = tosa.concat %5, %3 {axis = 0 : i32} : (tensor<7xf32>, tensor<7xf32>) -> tensor<14xf32>
    %7 = tosa.identity %6 : (tensor<14xf32>) -> tensor<14xf32>
    %8 = tosa.sigmoid %4 : (tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %2 : tensor<3x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<14xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

